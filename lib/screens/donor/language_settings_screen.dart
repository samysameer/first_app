import 'package:flutter/material.dart';
import '../../locale_provider.dart';
import '../../l10n/app_localizations.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(l10n.appLanguage),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black87,
      ),
      body: ValueListenableBuilder<Locale>(
        valueListenable: localeProvider,
        builder: (context, activeLocale, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _LanguageOption(
                  title: 'English',
                  subtitle: 'English',
                  isSelected: activeLocale.languageCode == 'en',
                  onTap: () {
                    localeProvider.setLocale(const Locale('en'));
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
                _LanguageOption(
                  title: 'العربية',
                  subtitle: 'Arabic',
                  isSelected: activeLocale.languageCode == 'ar',
                  onTap: () {
                    localeProvider.setLocale(const Locale('ar'));
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
                _LanguageOption(
                  title: 'Français',
                  subtitle: 'French',
                  isSelected: activeLocale.languageCode == 'fr',
                  onTap: () {
                    localeProvider.setLocale(const Locale('fr'));
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
                _LanguageOption(
                  title: 'Deutsch',
                  subtitle: 'German',
                  isSelected: activeLocale.languageCode == 'de',
                  onTap: () {
                    localeProvider.setLocale(const Locale('de'));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white60 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 28,
              )
            else
              Icon(
                Icons.circle_outlined,
                color: Colors.grey.shade400,
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}
