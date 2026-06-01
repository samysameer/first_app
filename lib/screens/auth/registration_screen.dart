import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../theme_provider.dart';
import '../../l10n/app_localizations.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final UserType initialType;
  const RegistrationScreen({Key? key, required this.initialType}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  late UserType _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
  }
  bool _isProcessing = false;
  bool _passwordVisible = false;

  String? _selectedBloodType;
  String? _selectedCity;

  final List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final List<String> _cities = [
    'Cairo', 'Alexandria', 'Giza', 'Port Said', 'Suez', 
    'Luxor', 'Mansoura', 'Tanta', 'Asyut', 'Ismailia', 
    'Fayoum', 'Zagazig', 'Aswan', 'Damietta', 'Minya',
    'Beni Suef', 'Qena', 'Sohag', 'Hurghada'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  Future<void> _handleRegistration() async {
    final l10n = AppLocalizations.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_selectedCity == null) {
      _showSnackBar(l10n.selectCity);
      return;
    }

    if (_selectedBloodType == null) {
      _showSnackBar(l10n.selectBloodType);
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => _isProcessing = true);

    try {
      final result = await AuthService.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
        userType: _selectedType,
        bloodType: _selectedBloodType,
        city: _selectedCity,
      );

      if (!mounted) return;

      if (!result.success) {
        _showSnackBar(result.error ?? l10n.registrationFailed);
        return;
      }

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(l10n.verifyEmail),
            content: Text(l10n.verifyMsg),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to selection
                },
                child: Text(l10n.ok),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      _showSnackBar(l10n.unexpectedError);
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 16, bottom: 48, left: 16, right: 24),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(Icons.favorite, color: Colors.white, size: 40),
                    ),
                    const SizedBox(height: 16),
                    const Text('E-Assist', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text(l10n.savingLives, style: const TextStyle(fontSize: 14, color: Colors.white70)),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(l10n.createAccount, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      '${l10n.registeringAs} ${_selectedType == UserType.donor ? l10n.donor : l10n.requester}',
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildField(
                            label: l10n.fullName, hint: l10n.aH, icon: Icons.person_outline,
                            controller: _nameController,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return l10n.enterFullName;
                              final nameParts = v.trim().split(RegExp(r'\s+'));
                              if (nameParts.length < 2) return l10n.enterTwoNames;
                              if (!RegExp(r'^[\p{L}\s]+$', unicode: true).hasMatch(v)) return l10n.lettersonly;
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildField(
                            label: l10n.email, hint: 'y***@example.com', icon: Icons.mail_outline,
                            controller: _emailController, keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return l10n.enterEmail;
                              if (!RegExp(r'^[a-zA-Z0-9.\-_]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(v.trim())) return l10n.enteravalidemail;
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildField(
                            label: l10n.phone, hint: '01*********', icon: Icons.phone_outlined,
                            controller: _phoneController, keyboardType: TextInputType.phone,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return l10n.enterPhone;
                              if (v.trim().length != 11) return l10n.phoneLengthError;
                              if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(v.trim())) return l10n.invalidEgyptianphonenumbe;
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildField(
                            label: l10n.password, hint: '******', icon: Icons.lock_outline,
                            controller: _passwordController, obscureText: !_passwordVisible,
                            isPassword: true,
                            onPasswordToggle: () => setState(() => _passwordVisible = !_passwordVisible),
                            validator: (v) {
                              if (v == null || v.isEmpty) return l10n.enterapassword;
                              if (v.length < 6) return l10n.passwordLengthError;
                              if (!RegExp(r'[a-zA-Z]').hasMatch(v)) return l10n.passwordLetterError;
                              if (!RegExp(r'[0-9]').hasMatch(v)) return l10n.passwordNumberError;
                              if (!RegExp(r'''[!@#\$&*~%^()_+=\-{}\[\]:;"'|<>,.?/]''').hasMatch(v)) return l10n.passwordSymbolError;
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildDropdownLabel(l10n.city),
                          const SizedBox(height: 8),
                          _buildDropdown<String>(
                            value: _selectedCity, hint: l10n.selectCity, items: _cities,
                            onChanged: (val) => setState(() => _selectedCity = val),
                            itemLabelMapper: (city) => _getLocalizedCity(city, l10n),
                          ),
                          const SizedBox(height: 20),
                          _buildDropdownLabel(l10n.bloodType),
                          const SizedBox(height: 8),
                          _buildDropdown<String>(
                            value: _selectedBloodType, hint: l10n.selectBloodType, items: _bloodTypes,
                            onChanged: (val) => setState(() => _selectedBloodType = val),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity, height: 56,
                            child: ElevatedButton(
                              onPressed: _isProcessing ? null : _handleRegistration,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: _isProcessing 
                                  ? const CircularProgressIndicator(color: Colors.white) 
                                  : Text(l10n.register, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.alreadyHaveAccount,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                              (route) => false,
                            );
                          },
                          child: Text(
                            l10n.login,
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        l10n.developedBy,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool obscureText = false,
    bool isPassword = false,
    VoidCallback? onPasswordToggle,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    bool isRequired = true,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            if (isRequired)
              const Text(' *', style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller, obscureText: obscureText, keyboardType: keyboardType,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint, prefixIcon: Icon(icon, color: Colors.grey),
            suffixIcon: isPassword ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey), onPressed: onPasswordToggle) : null,
            filled: true,
            fillColor: theme.brightness == Brightness.dark ? theme.cardColor : const Color(0xFFF9FAFB),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildDropdownLabel(String label, {bool isRequired = true}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        if (isRequired)
          const Text(' *', style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required T? value, 
    required String hint, 
    required List<T> items, 
    required ValueChanged<T?> onChanged,
    String Function(T)? itemLabelMapper,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark ? theme.cardColor : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value, isExpanded: true,
          dropdownColor: theme.cardColor,
          hint: Text(hint, style: const TextStyle(color: Colors.grey)),
          items: items.map((e) => DropdownMenuItem(
            value: e, 
            child: Text(itemLabelMapper != null ? itemLabelMapper(e) : e.toString())
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
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
      case 'Zagazig': return l10n.zagazig;
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
}
