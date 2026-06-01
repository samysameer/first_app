import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../services/auth_service.dart';
import '../../l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isDataLoaded = false;
  bool _isUploading = false;
  String? _email;
  String? _selectedBloodType;
  String? _selectedCity;
  String? _userType;
  String? _photoUrl;
  File? _localImageFile;
  String _imageTimestamp = DateTime.now().millisecondsSinceEpoch.toString();

  final List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final List<String> _cities = [
    'Cairo', 'Alexandria', 'Giza', 'Port Said', 'Suez',
    'Luxor', 'Mansoura', 'Tanta', 'Asyut', 'Ismailia',
    'Fayoum', 'Zagazig', 'Aswan', 'Damietta', 'Minya',
    'Beni Suef', 'Qena', 'Sohag', 'Hurghada'
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (pickedFile != null) {
      setState(() {
        _localImageFile = File(pickedFile.path);
        _isUploading = true;
      });
      final url = await AuthService.uploadProfileImage(_localImageFile!);
      setState(() {
        _isUploading = false;
        if (url != null) {
          _photoUrl = url;
          _imageTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
        }
      });

      if (url != null && mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profilephotoupdatedsucces)),
        );
      }
    }
  }

  String _getLocalizedCity(String city, AppLocalizations l10n) {
    switch (city) {
      case 'Cairo': return l10n.cairo;
      case 'Alexandria': return l10n.alexandria;
      case 'Giza': return l10n.giza;
      case 'Port Said': return l10n.portSaid;
      case 'Suez': return l10n.suez;
      case 'Luxor': return l10n.luxor;
      case 'Mansoura': return l10n.mansoura;
      case 'Tanta': return l10n.tanta;
      case 'Asyut': return l10n.asyut;
      case 'Ismailia': return l10n.ismailia;
      case 'Fayoum': return l10n.fayoum;
      case 'Zagagig': return l10n.zagazig;
      case 'Aswan': return l10n.aswan;
      case 'Damietta': return l10n.damietta;
      case 'Minya': return l10n.minya;
      case 'Beni Suef': return l10n.beniSuef;
      case 'Qena': return l10n.qena;
      case 'Sohag': return l10n.sohag;
      case 'Hurghada': return l10n.hurghada;
      default: return city;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (mounted) setState(() => _isDataLoaded = true);
      return;
    }

    try {
      final l10n = AppLocalizations.of(context);
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = doc.data() ?? {};

      if (!mounted) return;

      // Validate that the stored values actually exist in the dropdown lists
      final storedBloodType = data['bloodType'] as String?;
      final storedCity = data['city'] as String?;

      setState(() {
        _email = user.email;
        _nameController.text = data['name'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        _userType = data['userType'] as String?;
        _photoUrl = data['photoUrl'] as String?;
        _selectedBloodType = (storedBloodType != null && _bloodTypes.contains(storedBloodType))
            ? storedBloodType
            : null;
        _selectedCity = (storedCity != null && _cities.contains(storedCity))
            ? storedCity
            : null;
        _isDataLoaded = true;
      });
    } catch (e) {
      debugPrint('EditProfileScreen: Load Error: $e');
      if (mounted) {
        setState(() => _isDataLoaded = true);
        // We can't use l10n here if it failed above, so use a fallback or try again
        try {
          final l10n = AppLocalizations.of(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.failedLoadProfile)),
          );
        } catch (_) {}
      }
    }
  }

  Future<void> _saveProfile() async {
    final l10n = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Update Firestore profile data
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'bloodType': _selectedBloodType,
        'city': _selectedCity,
      }, SetOptions(merge: true));

      // Update password in Firebase Auth if provided
      if (_passwordController.text.isNotEmpty) {
        await user.updatePassword(_passwordController.text);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.profileUpdatedSuccess),
          backgroundColor: const Color(0xFF16A34A),
        ),
      );
      Navigator.pop(context, true);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      String message = l10n.failedUpdateProfile;
      if (e.code == 'requires-recent-login') {
        message = l10n.recentLoginRequired;
      } else if (e.code == 'weak-password') {
        message = l10n.weakPassword;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: const Color(0xFFDC2626)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.failedUpdateProfile),
          backgroundColor: const Color(0xFFDC2626),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          l10n.editProfile,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFFDC2626),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: !_isDataLoaded
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFDC2626)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Profile Icon
                    Center(
                      child: GestureDetector(
                        onTap: _isUploading ? null : _pickImage,
                        child: Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF3B1C1C) : const Color(0xFFFEE2E2),
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFDC2626).withOpacity(0.3), width: 3),
                              ),
                              child: ClipOval(
                                child: _localImageFile != null
                                    ? Image.file(_localImageFile!, fit: BoxFit.cover)
                                    : (_photoUrl != null
                                        ? Image.network(
                                            '$_photoUrl${_photoUrl!.contains('?') ? '&' : '?'}t=$_imageTimestamp',
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) =>
                                                const Icon(Icons.person, color: Color(0xFFDC2626), size: 40),
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return const Center(child: CircularProgressIndicator(color: Color(0xFFDC2626), strokeWidth: 2));
                                            },
                                          )
                                        : const Icon(Icons.person, color: Color(0xFFDC2626), size: 40)),
                              ),
                            ),
                            if (_isUploading)
                              Positioned.fill(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black45,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                  ),
                                ),
                              )
                            else
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFDC2626),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.camera_alt, color: Colors.white, size: 12),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        _email ?? '',
                        style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Section: Personal Info
                    _buildSectionLabel(l10n.personalInformation),
                    const SizedBox(height: 12),

                    // Full Name
                    _buildField(
                      label: l10n.fullName,
                      hint: l10n.nameExampleHint,
                      icon: Icons.person_outline,
                      controller: _nameController,
                      helperText: l10n.nameHint,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.enterFullName;
                        }
                        final parts = value.trim().split(RegExp(r'\s+'));
                        if (parts.length < 2) {
                          return l10n.enterTwoNames;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Phone
                    _buildField(
                      label: l10n.phone,
                      hint: '01012345678',
                      icon: Icons.phone_outlined,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      helperText: l10n.phoneHint,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.enterPhone;
                        }
                        if (!RegExp(r'^\d{11}$').hasMatch(value.trim())) {
                          return l10n.phoneLengthError;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Section: Security
                    _buildSectionLabel(l10n.changePasswordHeader),
                    const SizedBox(height: 4),
                    Text(
                      l10n.leaveEmptyPassword,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
                    ),
                    const SizedBox(height: 12),

                    // Password
                    _buildField(
                      label: l10n.newPassword,
                      hint: l10n.enterNewPasswordHint,
                      icon: Icons.lock_outline,
                      controller: _passwordController,
                      obscureText: true,
                      helperText: l10n.passwordHint,
                      validator: (value) {
                        // Password is optional on edit — only validate if something is entered
                        if (value == null || value.isEmpty) return null;
                        if (value.length < 6) {
                          return l10n.passwordLengthError;
                        }
                        if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                          return l10n.passwordLetterError;
                        }
                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return l10n.passwordNumberError;
                        }
                        if (!RegExp(r'[^a-zA-Z0-9\s]').hasMatch(value)) {
                          return l10n.passwordSymbolError;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Section: Health/Donor Info (available for all)
                    _buildSectionLabel(_userType == 'donor' ? l10n.donorInformation : (l10n.hEALTHINFORMATION)),
                    const SizedBox(height: 12),

                    // Blood Type
                    _buildDropdownField(
                      label: l10n.bloodType,
                      hint: l10n.selectBloodTypeHint,
                      icon: Icons.bloodtype_outlined,
                      value: _selectedBloodType,
                      items: _bloodTypes,
                      onChanged: (val) => setState(() => _selectedBloodType = val),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.selectBloodType;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // City (for all users)
                    _buildDropdownField(
                      label: l10n.city,
                      hint: l10n.selectCityHint,
                      icon: Icons.location_city_outlined,
                      value: _selectedCity,
                      items: _cities,
                      onChanged: (val) => setState(() => _selectedCity = val),
                      itemLabel: (item) => _getLocalizedCity(item, l10n),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.selectCity;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Save Button
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFDC2626),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                l10n.saveChanges,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Color(0xFF6B7280),
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
    String? helperText,
  }) {
    final theme = Theme.of(context);
    final isDarkField = theme.brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: isDarkField ? theme.cardColor : const Color(0xFFF9FAFB),
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFD1D5DB)),
        helperText: helperText,
        helperMaxLines: 2,
        helperStyle: const TextStyle(
          fontSize: 12,
          color: Color(0xFF6B7280),
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF9CA3AF),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: isDarkField ? const Color(0xFF334155) : const Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: isDarkField ? const Color(0xFF334155) : const Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDC2626)),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
    String? Function(String)? itemLabel,
  }) {
    final theme = Theme.of(context);
    final isDarkDrop = theme.brightness == Brightness.dark;
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((item) => DropdownMenuItem(
        value: item, 
        child: Text(itemLabel != null ? itemLabel(item) ?? item : item)
      )).toList(),
      onChanged: onChanged,
      dropdownColor: isDarkDrop ? theme.cardColor : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: isDarkDrop ? theme.cardColor : const Color(0xFFF9FAFB),
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFD1D5DB)),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF9CA3AF),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: isDarkDrop ? const Color(0xFF334155) : const Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: isDarkDrop ? const Color(0xFF334155) : const Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDC2626)),
        ),
      ),
      validator: validator,
    );
  }
}
