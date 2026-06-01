import 'package:flutter/material.dart';
import 'screens/platform_selection_screen.dart';

void main() {
  runApp(const DonationEmergencyApp());
}

class DonationEmergencyApp extends StatelessWidget {
  const DonationEmergencyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donation & Emergency Aid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFDC2626),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFDC2626),
          primary: const Color(0xFFDC2626),
          secondary: const Color(0xFFEA580C),
        ),
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const PlatformSelectionScreen(),
    );
  }
}
