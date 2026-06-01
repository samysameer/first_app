import 'package:flutter/material.dart';
import 'requester_home_screen.dart';
import 'emergency_form_screen.dart';
import 'ai_assistant_screen.dart';
import 'requester_history_screen.dart';
import '../donor/donor_profile_screen.dart';

class RequesterMainScreen extends StatefulWidget {
  const RequesterMainScreen({Key? key}) : super(key: key);

  @override
  State<RequesterMainScreen> createState() => _RequesterMainScreenState();
}

class _RequesterMainScreenState extends State<RequesterMainScreen> {
  late List<Widget> _screens;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _screens = [
      RequesterHomeScreen(onTabChange: (index) {
        setState(() {
          _currentIndex = index;
        });
      }),
      const EmergencyFormScreen(),
      const AIAssistantScreen(),
      const DonorProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _currentIndex == 1
                    ? const Color(0xFFDC2626)
                    : const Color(0xFF9CA3AF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.error_outline, color: Colors.white),
            ),
            label: 'SOS',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'AI Help',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
