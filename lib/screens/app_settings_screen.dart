import 'package:flutter/material.dart';
import 'legal_screen.dart';
import 'about_app_screen.dart';
import '../theme_provider.dart';
import '../l10n/app_localizations.dart';
import '../locale_provider.dart';
import '../widgets/language_selector_sheet.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _darkModeEnabled = appThemeModeNotifier.value == ThemeMode.dark;
    appThemeModeNotifier.addListener(_themeListener);
  }

  void _themeListener() {
    if (mounted) {
      setState(() {
        _darkModeEnabled = appThemeModeNotifier.value == ThemeMode.dark;
      });
    }
  }

  @override
  void dispose() {
    appThemeModeNotifier.removeListener(_themeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          l10n.appSettings,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader(l10n.preferences),
          _buildSwitchTile(
            context,
            title: l10n.pushNotifications,
            subtitle: l10n.receiveAlertsEmergencies,
            icon: Icons.notifications_active,
            iconColor: const Color(0xFF2563EB),
            iconBgColor: const Color(0xFFDBEAFE),
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          const SizedBox(height: 12),
          _buildSwitchTile(
            context,
            title: l10n.darkMode,
            subtitle: l10n.switchToDarkTheme,
            icon: Icons.dark_mode,
            iconColor: theme.colorScheme.onSurface,
            iconBgColor: theme.colorScheme.surfaceVariant,
            value: _darkModeEnabled,
            onChanged: (val) {
              ThemeProvider.toggleTheme();
            },
          ),
          const SizedBox(height: 12),
          _buildListTile(
            context,
            title: l10n.language,
            subtitle: localeProvider.value.languageCode == 'ar'
                ? 'العربية'
                : localeProvider.value.languageCode == 'fr'
                    ? 'Français'
                    : localeProvider.value.languageCode == 'de'
                        ? 'Deutsch'
                        : 'English',
            icon: Icons.language,
            iconColor: const Color(0xFF10B981),
            iconBgColor: const Color(0xFFD1FAE5),
            onTap: () => showLanguageSelectorSheet(context),
          ),
          const SizedBox(height: 32),

          _buildSectionHeader(l10n.about),
          _buildListTile(
            context,
            title: 'About E-Assist',
            icon: Icons.info_outline,
            iconColor: const Color(0xFF3B82F6),
            iconBgColor: const Color(0xFFEFF6FF),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutAppScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildListTile(
            context,
            title: l10n.termsOfService,
            icon: Icons.description,
            iconColor: const Color(0xFF8B5CF6),
            iconBgColor: const Color(0xFFEDE9FE),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LegalScreen(
                    title: l10n.termsOfService,
                    content: '''Welcome to our Terms of Service.

By using this app, you agree to follow all terms and conditions described here. We may update these terms occasionally. Continued use of the app after changes means you accept the updated terms.

Please use the app responsibly and contact support if you have any questions.''',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildListTile(
            context,
            title: l10n.privacyPolicy,
            icon: Icons.privacy_tip,
            iconColor: const Color(0xFFF59E0B),
            iconBgColor: const Color(0xFFFEF3C7),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LegalScreen(
                    title: l10n.privacyPolicy,
                    content: '''Your privacy is important to us.

We collect only the minimum information needed to provide the app services and keep your data secure. We do not sell your personal information.

By using this app, you consent to our privacy practices and the secure handling of your data.''',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildListTile(
            context,
            title: l10n.appVersion,
            subtitle: l10n.isArabic ? '1.0.0 (بناء 12)' : '1.0.0 (Build 12)',
            icon: Icons.info,
            iconColor: const Color(0xFF6B7280),
            iconBgColor: const Color(0xFFF3F4F6),
            onTap: null,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFF6B7280),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
        secondary: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        activeColor: const Color(0xFFDC2626),
        value: value,
        onChanged: onChanged,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required String title,
    String? subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: subtitle != null
            ? Text(subtitle, style: theme.textTheme.bodySmall)
            : null,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        trailing: onTap != null
            ? Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.iconTheme.color,
              )
            : null,
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
