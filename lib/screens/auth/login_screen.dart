import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_button.dart';
import '../../locale_provider.dart';
import '../../theme_provider.dart';
import '../../l10n/app_localizations.dart';
import '../donor/donor_main_screen.dart';
import '../requester/requester_main_screen.dart';
import 'registration_screen.dart';
import 'forgot_password_screen.dart';
import 'account_selection_screen.dart';
import '../../widgets/language_selector_sheet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isProcessing = false;
  bool _passwordVisible = false;
  UserType _selectedRole = UserType.donor;


  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void _navigateToHome(UserType role) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => role == UserType.donor ? const DonorMainScreen() : const RequesterMainScreen(),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    FocusScope.of(context).unfocus();
    setState(() => _isProcessing = true);

    try {
      final AuthResult result;
      final identifier = _identifierController.text.trim();
      final isEmail = identifier.contains('@');

      if (isEmail) {
        result = await AuthService.login(
          identifier,
          _passwordController.text,
        );
      } else {
        result = await AuthService.loginWithPhone(
          identifier,
          _passwordController.text,
        );
      }

      if (!mounted) return;

      if (!result.success) {
        _showSnackBar(result.error ?? 'Invalid credentials.');
        return;
      }

      if (result.user!.userType != _selectedRole) {
        final roleName = _selectedRole == UserType.donor ? 'Donor' : 'Requester';
        _showSnackBar('This account is not registered as a $roleName.');
        return;
      }

      _navigateToHome(result.user!.userType);
    } catch (error) {
      if (mounted) _showSnackBar('Login failed. Please try again.');
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Red Header (Same as before)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60)),
                      ),
                      child: SafeArea(
                        bottom: false,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: Colors.white, size: 20),
                                  onPressed: () => ThemeProvider.toggleTheme(),
                                ),
                                 TextButton.icon(
                                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                                  icon: const Icon(Icons.language, size: 18),
                                  label: Text(
                                    localeProvider.value.languageCode == 'ar'
                                        ? 'العربية'
                                        : localeProvider.value.languageCode == 'fr'
                                            ? 'Français'
                                            : localeProvider.value.languageCode == 'de'
                                                ? 'Deutsch'
                                                : 'English',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  onPressed: () => showLanguageSelectorSheet(context),
                                ),
                              ],
                            ),
                            Container(
                              width: 60, height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.emergency, color: Color(0xFFDC2626), size: 40),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(text: 'E-Assist', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: const Offset(2, -14),
                                      child: const Text('™', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(l10n.savingLives, style: const TextStyle(fontSize: 14, color: Color(0xFFFFD8D8))),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(l10n.welcomeBack, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),

                          // Role Selector
                          Container(
                            height: 54, padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isDark ? theme.cardColor : const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Expanded(child: _buildToggleTab(_selectedRole == UserType.donor, l10n.donor, () => setState(() => _selectedRole = UserType.donor))),
                                Expanded(child: _buildToggleTab(_selectedRole == UserType.requester, l10n.requester, () => setState(() => _selectedRole = UserType.requester))),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: _identifierController,
                                  hint: '${l10n.email} / ${l10n.phone}',
                                  icon: Icons.person_outline,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (v) => (v == null || v.isEmpty) ? '${l10n.enterEmail} / ${l10n.enterPhone}' : null,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  controller: _passwordController,
                                  hint: l10n.password,
                                  icon: Icons.lock_outline,
                                  isPassword: true,
                                  obscureText: !_passwordVisible,
                                  onToggleVisibility: () => setState(() => _passwordVisible = !_passwordVisible),
                                  validator: (v) => (v == null || v.isEmpty) ? l10n.enterPassword : null,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen())),
                                    child: Text(l10n.forgotPassword, style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                LoadingButton(text: l10n.login, onPressed: _handleLogin, isLoading: _isProcessing),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Footer (Copyright and Developer info)
                    _buildFooter(isDark, theme, l10n),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }





  Widget _buildToggleTab(bool isSelected, String label, VoidCallback onTap) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? (theme.brightness == Brightness.dark ? Colors.grey[800] : Colors.white) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))] : null,
        ),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(color: isSelected ? theme.primaryColor : Colors.grey, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildFooter(bool isDark, ThemeData theme, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.dontHaveAccount, style: TextStyle(color: isDark ? Colors.white70 : Colors.grey)),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountSelectionScreen())),
                child: Text(l10n.registerNow, style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(l10n.copyright, style: TextStyle(fontSize: 10, color: Colors.grey.withOpacity(0.6))),
          const SizedBox(height: 8),
          Text(l10n.developedBy, style: TextStyle(fontSize: 12, color: Colors.grey.withOpacity(0.8), fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
