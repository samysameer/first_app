import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'donor_home_screen.dart';
import 'donor_map_screen.dart';
import 'donor_notifications_screen.dart';
import 'donor_profile_screen.dart';

class DonorMainScreen extends StatefulWidget {
  const DonorMainScreen({Key? key}) : super(key: key);

  @override
  State<DonorMainScreen> createState() => _DonorMainScreenState();
}

class _DonorMainScreenState extends State<DonorMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DonorHomeScreen(),
    const DonorMapScreen(),
    const DonorNotificationsScreen(),
    const DonorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).cardColor
            : Colors.white,
        selectedItemColor: const Color(0xFFDC2626),
        unselectedItemColor: const Color(0xFF9CA3AF),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: l10n.navMap,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
            label: l10n.navAlerts,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }
}
