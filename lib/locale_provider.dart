import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final LocaleProvider localeProvider = LocaleProvider();

class LocaleProvider extends ValueNotifier<Locale> {
  LocaleProvider() : super(const Locale('en')) {
    _loadLocale();
  }

  static const String _localeKey = 'app_locale';

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString(_localeKey);
    if (languageCode != null) {
      value = Locale(languageCode);
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (value == locale) return;
    value = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  void toggleLocale() {
    if (value.languageCode == 'en') {
      setLocale(const Locale('ar'));
    } else {
      setLocale(const Locale('en'));
    }
  }

  bool get isArabic => value.languageCode == 'ar';
}
