import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';

class EmergencyDetailsScreen extends StatelessWidget {
  final String emergencyId;
  final Map<String, dynamic> data;
  final String distance;

  const EmergencyDetailsScreen({
    Key? key,
    required this.emergencyId,
    required this.data,
    required this.distance,
  }) : super(key: key);

  void _openMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _makeCall(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Future<void> _openDirections(double lat, double lng) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _acceptRequest(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final batch = FirebaseFirestore.instance.batch();
      
      // 1. Update emergency status
      batch.update(FirebaseFirestore.instance.collection('emergencies').doc(emergencyId), {
        'status': 'accepted',
        'donorId': user.uid,
        'acceptedAt': FieldValue.serverTimestamp(),
      });

      // 2. Create donation record
      final type = data['type'] ?? 'blood';
      final donationRef = FirebaseFirestore.instance.collection('donations').doc();
      batch.set(donationRef, {
        'donorId': user.uid,
        'emergencyId': emergencyId,
        'type': type == 'blood' ? 'Blood' : 'Medical',
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'Completed',
      });

      // 3. Update user stats
      batch.update(FirebaseFirestore.instance.collection('users').doc(user.uid), {
        'livesSaved': FieldValue.increment(1),
      });

      await batch.commit();

      final lat = data['latitude'] as double?;
      final lng = data['longitude'] as double?;
      if (lat != null && lng != null) {
        _openDirections(lat, lng);
      }
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.requestacceptedsuccessful)),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.somethingwentwrong)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    
    final type = data['type'] ?? 'blood';
    final urgency = data['urgency'] ?? 'medium';
    final name = data['name'] ?? l10n.user;
    final phone = data['phone'] ?? '';
    final description = data['description'] ?? '';
    final locationName = data['locationName'] ?? '';
    final lat = data['latitude'] as double?;
    final lng = data['longitude'] as double?;
    final bloodType = data['bloodType'] ?? '--';

    Color urgencyColor;
    switch (urgency) {
      case 'critical': urgencyColor = const Color(0xFFDC2626); break;
      case 'high': urgencyColor = const Color(0xFFEA580C); break;
      default: urgencyColor = const Color(0xFFD97706);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.emergencyDetails),
        backgroundColor: urgencyColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              color: urgencyColor,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: Icon(
                      type == 'blood' ? Icons.bloodtype : (type == 'medical' ? Icons.medical_services : Icons.emergency),
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    l10n.needsyourhelp,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Info Row
                  Row(
                    children: [
                      _DetailChip(
                        icon: Icons.priority_high,
                        label: urgency.toUpperCase(),
                        color: urgencyColor,
                      ),
                      const SizedBox(width: 8),
                      _DetailChip(
                        icon: Icons.location_on,
                        label: distance,
                        color: Colors.blue,
                      ),
                      if (type == 'blood') ...[
                        const SizedBox(width: 8),
                        _DetailChip(
                          icon: Icons.favorite,
                          label: bloodType,
                          color: const Color(0xFFDC2626),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description Section
                  Text(
                    l10n.description,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16, color: isDark ? Colors.white70 : Colors.black87),
                  ),
                  const SizedBox(height: 24),

                  // Location Section
                  Text(
                    l10n.location,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => lat != null && lng != null ? _openMaps(lat, lng) : null,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? theme.cardColor : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.map, color: Colors.blue),
                          const SizedBox(width: 12),
                          Expanded(child: Text(locationName)),
                          const Icon(Icons.open_in_new, size: 16, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Contact Section
                  if (phone.isNotEmpty) ...[
                    Text(
                      l10n.contactInformation,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.withOpacity(0.1),
                        child: const Icon(Icons.phone, color: Colors.green),
                      ),
                      title: Text(phone),
                      trailing: IconButton(
                        icon: const Icon(Icons.call, color: Colors.green),
                        onPressed: () => _makeCall(phone),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => _acceptRequest(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: urgencyColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                      ),
                      child: Text(
                        l10n.acceptRequestGo,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _DetailChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
