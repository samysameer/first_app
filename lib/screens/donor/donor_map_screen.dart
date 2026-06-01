import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../l10n/app_localizations.dart';
import 'emergency_details_screen.dart';

// --- Model ---
enum EmergencyStatus { critical, high, medium }
enum EmergencyType { blood, medical, rescue }

class EmergencyMarker {
  final String id;
  final LatLng position;
  final EmergencyType type;
  final EmergencyStatus status;
  final String title;
  final Map<String, dynamic> rawData;

  EmergencyMarker({
    required this.id,
    required this.position,
    required this.type,
    required this.status,
    required this.title,
    required this.rawData,
  });
}

class DonorMapScreen extends StatefulWidget {
  const DonorMapScreen({Key? key}) : super(key: key);

  @override
  State<DonorMapScreen> createState() => _DonorMapScreenState();
}

class _DonorMapScreenState extends State<DonorMapScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  LatLng? _userLocation;
  bool _isSearching = false;
  StreamSubscription<QuerySnapshot>? _emergenciesSubscription;
  List<EmergencyMarker> _allMarkers = [];
  
  // Cairo Center
  static const LatLng _cairoCenter = LatLng(30.0444, 31.2357);

  List<EmergencyMarker> get _filteredMarkers {
    if (_selectedFilter == 'All') return _allMarkers;
    return _allMarkers.where((m) => m.type.name.toLowerCase() == _selectedFilter.toLowerCase()).toList();
  }

  Color _getStatusColor(EmergencyStatus status) {
    switch (status) {
      case EmergencyStatus.critical: return Colors.red;
      case EmergencyStatus.high: return Colors.orange;
      case EmergencyStatus.medium: return Colors.yellow;
    }
  }

  @override
  void initState() {
    super.initState();
    _updateUserLocation();
    _subscribeToEmergencies();
  }

  @override
  void dispose() {
    _emergenciesSubscription?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _subscribeToEmergencies() {
    _emergenciesSubscription = FirebaseFirestore.instance
        .collection('emergencies')
        .where('status', isEqualTo: 'active')
        .snapshots()
        .listen((snapshot) {
      if (!mounted) return;
      
      final List<EmergencyMarker> loadedMarkers = [];
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final double? lat = data['latitude'] as double?;
        final double? lng = data['longitude'] as double?;
        if (lat != null && lng != null) {
          final typeStr = data['type'] as String?;
          final urgencyStr = data['urgency'] as String?;
          
          EmergencyType type = EmergencyType.blood;
          if (typeStr == 'medical') type = EmergencyType.medical;
          if (typeStr == 'rescue') type = EmergencyType.rescue;
          
          EmergencyStatus status = EmergencyStatus.medium;
          if (urgencyStr == 'critical') status = EmergencyStatus.critical;
          if (urgencyStr == 'high') status = EmergencyStatus.high;
          
          final bloodType = data['bloodType'] ?? '';
          final description = data['description'] ?? '';
          
          String title = description.isNotEmpty 
              ? description 
              : (type == EmergencyType.blood ? 'Urgent: Blood Needed' : 'Emergency Assistance Required');
          if (type == EmergencyType.blood && bloodType.toString().isNotEmpty) {
            title = '🩸 $bloodType Blood Needed: $title';
          }
          
          loadedMarkers.add(
            EmergencyMarker(
              id: doc.id,
              position: LatLng(lat, lng),
              type: type,
              status: status,
              title: title,
              rawData: data,
            ),
          );
        }
      }
      
      setState(() {
        _allMarkers = loadedMarkers;
      });
    }, onError: (error) {
      debugPrint('Firestore subscription error: $error');
    });
  }

  Future<void> _handleSearch() async {
    final l10n = AppLocalizations.of(context);
    if (_searchController.text.isEmpty) return;
    
    setState(() => _isSearching = true);
    try {
      List<Location> locations = await locationFromAddress(_searchController.text);
      if (locations.isNotEmpty) {
        LatLng target = LatLng(locations.first.latitude, locations.first.longitude);
        _mapController.move(target, 14);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.locationNotFound)),
      );
    } finally {
      setState(() => _isSearching = false);
    }
  }

  Future<void> _updateUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
    });
    _mapController.move(_userLocation!, 15);
  }

  void _filterAndMove(String filter) {
    setState(() {
      _selectedFilter = filter;
    });

    // Automatically adjust map to fit filtered markers
    final filtered = _filteredMarkers;
    if (filtered.isNotEmpty && _mapController != null) {
      // Find bounds
      double minLat = filtered.first.position.latitude;
      double maxLat = filtered.first.position.latitude;
      double minLng = filtered.first.position.longitude;
      double maxLng = filtered.first.position.longitude;

      for (var m in filtered) {
        if (m.position.latitude < minLat) minLat = m.position.latitude;
        if (m.position.latitude > maxLat) maxLat = m.position.latitude;
        if (m.position.longitude < minLng) minLng = m.position.longitude;
        if (m.position.longitude > maxLng) maxLng = m.position.longitude;
      }

      // Move camera to center of filtered markers
      _mapController.move(
        LatLng((minLat + maxLat) / 2, (minLng + maxLng) / 2),
        13.5, // Slightly zoom in
      );
    }
  }

  Widget _FilterItem(String label, String value, bool isSelected, Function(String) onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xFFDC2626) : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black87,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 4,
        ),
        onPressed: () => onTap(value),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // 1. Map
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: _cairoCenter,
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.finalproject',
                tileBuilder: isDark ? (context, tileWidget, tile) {
                  return ColorFiltered(
                    colorFilter: const ColorFilter.matrix([
                      -1, 0, 0, 0, 255, -1, 0, 0, 0, 255, -1, 0, 0, 0, 255, 0, 0, 0, 1, 0,
                    ]),
                    child: tileWidget,
                  );
                } : null,
              ),
              MarkerLayer(
                markers: [
                  // User Location Marker (Blue Dot)
                  if (_userLocation != null)
                    Marker(
                      point: _userLocation!,
                      width: 40,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Center(
                          child: Icon(Icons.person_pin_circle, color: Colors.blue, size: 28),
                        ),
                      ),
                    ),
                  // Emergency Markers
                  ..._filteredMarkers.map((em) {
                    return Marker(
                      point: em.position,
                      width: 50,
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          // Calculate distance between user and marker
                          String distanceStr = '-- km';
                          if (_userLocation != null) {
                            double distanceInMeters = Geolocator.distanceBetween(
                              _userLocation!.latitude,
                              _userLocation!.longitude,
                              em.position.latitude,
                              em.position.longitude,
                            );
                            distanceStr = '${(distanceInMeters / 1000).toStringAsFixed(1)} km';
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmergencyDetailsScreen(
                                emergencyId: em.id,
                                data: em.rawData,
                                distance: distanceStr,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _getStatusColor(em.status).withOpacity(0.3),
                            shape: BoxShape.circle,
                            border: Border.all(color: _getStatusColor(em.status), width: 2),
                          ),
                          child: Icon(_getTypeIcon(em.type), color: _getStatusColor(em.status), size: 20),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),

          // 2. Top UI Overlay (Search + Filters)
          SafeArea(
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: l10n.searchHint,
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFFDC2626)),
                        suffixIcon: _isSearching 
                            ? const Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(strokeWidth: 2))
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (_searchController.text.isNotEmpty)
                                    IconButton(
                                      icon: const Icon(Icons.clear, color: Colors.grey),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {});
                                      },
                                    ),
                                  IconButton(
                                    icon: const Icon(Icons.arrow_forward), 
                                    onPressed: _handleSearch
                                  ),
                                ],
                              ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onChanged: (value) => setState(() {}),
                      onSubmitted: (_) => _handleSearch(),
                    ),
                  ),
                ),
                // Filter Buttons
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _FilterItem(l10n.allMarkers, 'All', _selectedFilter == 'All', _filterAndMove),
                      _FilterItem(l10n.bloodFilter, 'Blood', _selectedFilter == 'Blood', _filterAndMove),
                      _FilterItem(l10n.medicalFilter, 'Medical', _selectedFilter == 'Medical', _filterAndMove),
                      _FilterItem(l10n.rescueFilter, 'Rescue', _selectedFilter == 'Rescue', _filterAndMove),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. Legend Box
          Positioned(
            top: 160,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLegendItem(Colors.red, l10n.criticalPriority),
                  const SizedBox(height: 8),
                  _buildLegendItem(Colors.orange, l10n.highPriority),
                  const SizedBox(height: 8),
                  _buildLegendItem(Colors.yellow, l10n.mediumPriority),
                  const SizedBox(height: 8),
                  _buildLegendItem(Colors.blue, 'You'),
                ],
              ),
            ),
          ),
        ],
      ),
      // 4. Location Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFDC2626),
        onPressed: _updateUserLocation,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }

  IconData _getTypeIcon(EmergencyType type) {
    switch (type) {
      case EmergencyType.blood: return Icons.water_drop;
      case EmergencyType.medical: return Icons.medical_services;
      case EmergencyType.rescue: return Icons.local_hospital;
    }
  }
}
