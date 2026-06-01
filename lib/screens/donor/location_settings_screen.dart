import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../l10n/app_localizations.dart';

class LocationSettingsScreen extends StatefulWidget {
  const LocationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<LocationSettingsScreen> createState() => _LocationSettingsScreenState();
}

class _LocationSettingsScreenState extends State<LocationSettingsScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;
  
  double? _localSearchRadius;

  Future<void> _updateSetting(String key, dynamic value) async {
    if (_user != null) {
      try {
        await _firestore.collection('users').doc(_user!.uid).set({
          'locationSettings': {
            key: value,
          }
        }, SetOptions(merge: true));
      } catch (e) {
        debugPrint('Failed to update setting: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.locationSettings),
        backgroundColor: const Color(0xFFDC2626),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('users').doc(_user?.uid).snapshots(),
        builder: (context, snapshot) {
          bool shareLiveLocation = true;
          bool backgroundLocation = false;
          double dbSearchRadius = 10.0;

          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            final settings = data['locationSettings'] as Map<String, dynamic>?;
            if (settings != null) {
              shareLiveLocation = settings['shareLiveLocation'] ?? true;
              backgroundLocation = settings['backgroundLocation'] ?? false;
              dbSearchRadius = (settings['searchRadius'] ?? 10.0).toDouble();
            }
          }

          final displayRadius = _localSearchRadius ?? dbSearchRadius;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSectionHeader(l10n.permissions),
              _buildSettingCard(
                child: SwitchListTile(
                  title: Text(l10n.shareLiveLocation, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(l10n.allowOthersSeeLocation, style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                  value: shareLiveLocation,
                  onChanged: (val) {
                    _updateSetting('shareLiveLocation', val);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(val 
                          ? (l10n.livelocationsharingenable) 
                          : (l10n.livelocationsharingdisabl)),
                      duration: const Duration(seconds: 2),
                    ));
                  },
                  activeColor: const Color(0xFFDC2626),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
              const SizedBox(height: 12),
              _buildSettingCard(
                child: SwitchListTile(
                  title: Text(l10n.backgroundLocation, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(l10n.receiveAlertsAppClosed, style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                  value: backgroundLocation,
                  onChanged: (val) async {
                    if (val) {
                      await Geolocator.requestPermission();
                    }
                    _updateSetting('backgroundLocation', val);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(val 
                            ? (l10n.backgroundlocationenabled) 
                            : (l10n.backgroundlocationdisable)),
                        duration: const Duration(seconds: 2),
                      ));
                    }
                  },
                  activeColor: const Color(0xFFDC2626),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(l10n.preferences),
              _buildSettingCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.emergencySearchRadius,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF2F2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${displayRadius.toInt()} ${l10n.isArabic ? 'كم' : 'km'}',
                              style: const TextStyle(
                                color: Color(0xFFDC2626),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SliderTheme(
                        data: SliderThemeData(
                          activeTrackColor: const Color(0xFFDC2626),
                          inactiveTrackColor: const Color(0xFFFCA5A5),
                          thumbColor: const Color(0xFFDC2626),
                          overlayColor: const Color(0xFFDC2626).withOpacity(0.2),
                          trackHeight: 6.0,
                          valueIndicatorColor: const Color(0xFFDC2626),
                        ),
                        child: Slider(
                          value: displayRadius,
                          min: 1,
                          max: 50,
                          divisions: 49,
                          label: '${displayRadius.toInt()} ${l10n.isArabic ? 'كم' : 'km'}',
                          onChanged: (val) {
                            setState(() {
                              _localSearchRadius = val;
                            });
                          },
                          onChangeEnd: (val) {
                            _updateSetting('searchRadius', val);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.isArabic 
                                  ? 'تم تحديث نطاق البحث إلى ${val.toInt()} كم' 
                                  : 'Search radius updated to ${val.toInt()} km'),
                              duration: const Duration(seconds: 2),
                            ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () async {
                  await Geolocator.openLocationSettings();
                  await Geolocator.openAppSettings();
                },
                icon: const Icon(Icons.settings_applications),
                label: Text(l10n.openSystemSettings),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSettingCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFFDC2626),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
