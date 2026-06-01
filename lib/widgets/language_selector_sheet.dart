import 'package:flutter/material.dart';
import '../locale_provider.dart';

void showLanguageSelectorSheet(BuildContext context) {
  final theme = Theme.of(context);

  final languages = [
    {'name': 'English', 'code': 'en', 'flag': '🇬🇧'},
    {'name': 'العربية', 'code': 'ar', 'flag': '🇪🇬'},
    {'name': 'Français', 'code': 'fr', 'flag': '🇫🇷'},
    {'name': 'Deutsch', 'code': 'de', 'flag': '🇩🇪'},
  ];

  showModalBottomSheet(
    context: context,
    backgroundColor: theme.scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (BuildContext context) {
      return ValueListenableBuilder<Locale>(
        valueListenable: localeProvider,
        builder: (context, activeLocale, _) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    activeLocale.languageCode == 'ar'
                        ? 'اختر اللغة'
                        : activeLocale.languageCode == 'fr'
                            ? 'Choisir la langue'
                            : activeLocale.languageCode == 'de'
                                ? 'Sprache wählen'
                                : 'Choose Language',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ...languages.map((lang) {
                    final isSelected = activeLocale.languageCode == lang['code'];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? theme.primaryColor.withOpacity(0.1) 
                              : theme.cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected 
                                ? theme.primaryColor 
                                : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: ListTile(
                          leading: Text(
                            lang['flag']!,
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(
                            lang['name']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? theme.primaryColor : theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          trailing: isSelected
                              ? Icon(Icons.check_circle, color: theme.primaryColor)
                              : null,
                          onTap: () {
                            localeProvider.setLocale(Locale(lang['code']!));
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        }
      );
    },
  );
}
