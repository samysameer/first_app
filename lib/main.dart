import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';
import 'screens/auth/login_screen.dart';
import 'theme_provider.dart';
import 'locale_provider.dart';
import 'l10n/app_localizations.dart';
import 'widgets/session_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ThemeProvider.loadSavedTheme();
  runApp(const DonationEmergencyApp());
}

class DonationEmergencyApp extends StatelessWidget {
  const DonationEmergencyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeProvider,
      builder: (context, locale, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: appThemeModeNotifier,
          builder: (context, themeMode, child) {
            return MaterialApp(
              title: 'E-Assist',
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              locale: locale,
              localizationsDelegates: const [
                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('ar', ''),
                Locale('fr', ''),
                Locale('de', ''),
              ],
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: const Color(0xFFDC2626),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFFDC2626),
                  primary: const Color(0xFFDC2626),
                  secondary: const Color(0xFFEA580C),
                  brightness: Brightness.light,
                ),
                scaffoldBackgroundColor: const Color(0xFFF9FAFB),
                fontFamily: 'Inter',
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: const Color(0xFFDC2626),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFFDC2626),
                  primary: const Color(0xFFDC2626),
                  secondary: const Color(0xFFEA580C),
                  brightness: Brightness.dark,
                ),
                scaffoldBackgroundColor: const Color(0xFF0F172A),
                cardColor: const Color(0xFF1E293B),
                canvasColor: const Color(0xFF0F172A),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF111827),
                  foregroundColor: Colors.white,
                ),
                useMaterial3: true,
              ),
              builder: (context, child) {
                return SessionWrapper(child: child!);
              },
              home: const LoginScreen(),
            );
          },
        );
      },
    );
  }
}
