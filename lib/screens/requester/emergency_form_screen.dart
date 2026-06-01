import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import '../../services/ai_service.dart';
import '../../l10n/app_localizations.dart';

class EmergencyFormScreen extends StatefulWidget {
  const EmergencyFormScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyFormScreen> createState() => _EmergencyFormScreenState();
}

class _EmergencyFormScreenState extends State<EmergencyFormScreen> {
  int _currentStep = 0;
  String _selectedType = '';
  String _selectedUrgency = 'critical';
  String _selectedBloodType = '';
  final _descriptionController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isSubmitting = false;
  bool _isAnalyzing = false;
  String _aiFirstAidTip = '';

  Future<void> _submitRequest() async {
    final l10n = AppLocalizations.of(context);
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.fillAllDetails)),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final user = FirebaseAuth.instance.currentUser;

      String locationName = 'Unknown Location';
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          locationName = '${place.street}, ${place.locality}';
        }
      } catch (e) {
        debugPrint('Geocoding error: $e');
      }

      await FirebaseFirestore.instance.collection('emergencies').add({
        'type': _selectedType,
        'urgency': _selectedUrgency,
        'bloodType': _selectedBloodType,
        'description': _descriptionController.text,
        'name': _nameController.text,
        'phone': _phoneController.text,
        'latitude': position.latitude,
        'longitude': position.longitude,
        'locationName': locationName,
        'userId': user?.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'active',
      });

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => _SuccessDialog(onBack: () {
            setState(() {
              _currentStep = 0;
            });
          }),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _analyzeWithAI() async {
    final l10n = AppLocalizations.of(context);
    if (_descriptionController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.longerDescriptionAI)),
      );
      return;
    }

    setState(() => _isAnalyzing = true);

    try {
      final result = await AIService.analyzeEmergency(_descriptionController.text);
      
      setState(() {
        if (result['urgency'] != null) _selectedUrgency = result['urgency'];
        if (result['type'] != null && result['type'] != 'unknown') _selectedType = result['type'];
        if (result['first_aid_tip'] != null) _aiFirstAidTip = result['first_aid_tip'];
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.aiAnalysisComplete),
            backgroundColor: const Color(0xFF16A34A),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.aiAnalysisFailed}: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isAnalyzing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        if (_currentStep > 0) {
          setState(() {
            _currentStep = 0;
          });
        } else {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: const Color(0xFFDC2626),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (_currentStep > 0)
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _currentStep = 0;
                            });
                          },
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.emergencyRequest,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _currentStep == 0
                                  ? l10n.selectEmergencyType
                                  : l10n.provideDetails,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFECACA),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Progress Bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: _currentStep >= 0
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: _currentStep >= 1
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _currentStep == 0 ? _buildTypeSelection() : _buildDetailsForm(),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildTypeSelection() {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.whatHelpNeeded,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 16),
        _EmergencyTypeCard(
          emoji: '🩸',
          title: l10n.bloodDonation,
          description: l10n.bloodDonationDesc,
          isSelected: _selectedType == 'blood',
          onTap: () {
            setState(() {
              _selectedType = 'blood';
              _currentStep = 1;
            });
          },
        ),
        const SizedBox(height: 16),
        _EmergencyTypeCard(
          emoji: '💊',
          title: l10n.medicalSuppliesRequest,
          description: l10n.medicalSuppliesDesc,
          isSelected: _selectedType == 'medical',
          onTap: () {
            setState(() {
              _selectedType = 'medical';
              _currentStep = 1;
            });
          },
        ),
        const SizedBox(height: 16),
        _EmergencyTypeCard(
          emoji: '🚑',
          title: l10n.emergencyRescue,
          description: l10n.emergencyRescueDesc,
          isSelected: _selectedType == 'rescue',
          onTap: () {
            setState(() {
              _selectedType = 'rescue';
              _currentStep = 1;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDetailsForm() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Urgency Level
        Text(
          l10n.urgencyLevel,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _UrgencyButton(
                label: l10n.criticalLabel,
                isSelected: _selectedUrgency == 'critical',
                color: const Color(0xFFDC2626),
                onTap: () => setState(() => _selectedUrgency = 'critical'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _UrgencyButton(
                label: l10n.highLabel,
                isSelected: _selectedUrgency == 'high',
                color: const Color(0xFFEA580C),
                onTap: () => setState(() => _selectedUrgency = 'high'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _UrgencyButton(
                label: l10n.mediumLabel,
                isSelected: _selectedUrgency == 'medium',
                color: const Color(0xFFD97706),
                onTap: () => setState(() => _selectedUrgency = 'medium'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Blood Type (if blood donation)
        if (_selectedType == 'blood') ...[
          Text(
            l10n.bloodTypeNeeded,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2,
            children: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                .map((type) => _BloodTypeButton(
                      type: type,
                      isSelected: _selectedBloodType == type,
                      onTap: () => setState(() => _selectedBloodType = type),
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
        ],

        // Description
        Text(
          l10n.descriptionLabel,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _descriptionController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: l10n.descriptionHint,
            filled: true,
            fillColor: isDark ? theme.cardColor : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFDC2626), width: 2),
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (_isAnalyzing)
          Center(
            child: Column(
              children: [
                const CircularProgressIndicator(color: Color(0xFFDC2626)),
                const SizedBox(height: 8),
                Text(l10n.aiAnalyzing, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          )
        else
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _analyzeWithAI,
              icon: const Icon(Icons.auto_awesome, size: 18),
              label: Text(l10n.smartAnalyzeAI),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFDC2626),
                side: const BorderSide(color: Color(0xFFDC2626)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        const SizedBox(height: 12),
        if (_aiFirstAidTip.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFCA5A5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.health_and_safety, color: Color(0xFFDC2626), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      l10n.aiFirstAidTipLabel,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF991B1B)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _aiFirstAidTip,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF7F1D1D)),
                ),
              ],
            ),
          ),
        const SizedBox(height: 24),

        // Contact Name
        Text(
          l10n.yourName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: l10n.yourNameHint,
            filled: true,
            fillColor: isDark ? theme.cardColor : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFDC2626), width: 2),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Phone Number
        Text(
          l10n.phoneNumber,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: '+20 123 456 7890',
            prefixIcon: const Icon(Icons.phone, color: Color(0xFF9CA3AF)),
            filled: true,
            fillColor: isDark ? theme.cardColor : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFDC2626), width: 2),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Submit Button
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitRequest,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFDC2626),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
          child: _isSubmitting
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  l10n.submitEmergencyRequest,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ],
    );
  }
}

class _EmergencyTypeCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _EmergencyTypeCard({
    Key? key,
    required this.emoji,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFDC2626) : (isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB)),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
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

class _UrgencyButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _UrgencyButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : (isDark ? theme.cardColor : Colors.white),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : (isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB)),
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : color,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _BloodTypeButton extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback onTap;

  const _BloodTypeButton({
    Key? key,
    required this.type,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDC2626) : (isDark ? theme.cardColor : Colors.white),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFDC2626) : (isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB)),
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            type,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : const Color(0xFF374151),
            ),
          ),
        ),
      ),
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  final VoidCallback onBack;
  const _SuccessDialog({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFFDCFCE7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Color(0xFF16A34A),
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.requestSent,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.broadcastingMsg,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Pop dialog
                onBack(); // Reset form step
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                l10n.backToHome,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
