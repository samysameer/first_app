import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import '../screens/auth/login_screen.dart';
import '../l10n/app_localizations.dart';

class SessionWrapper extends StatefulWidget {
  final Widget child;
  final Duration timeoutDuration;

  const SessionWrapper({
    Key? key,
    required this.child,
    this.timeoutDuration = const Duration(minutes: 1),
  }) : super(key: key);

  @override
  State<SessionWrapper> createState() => _SessionWrapperState();
}

class _SessionWrapperState extends State<SessionWrapper> with WidgetsBindingObserver {
  static const String _sessionKey = 'last_background_time';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkInitialSession();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _checkInitialSession() async {
    final prefs = await SharedPreferences.getInstance();
    final lastTime = prefs.getInt(_sessionKey);
    
    if (lastTime != null) {
      final lastDateTime = DateTime.fromMillisecondsSinceEpoch(lastTime);
      final durationAway = DateTime.now().difference(lastDateTime);
      
      if (durationAway > widget.timeoutDuration) {
        _handleSessionTimeout();
      }
      // Clear it after checking
      await prefs.remove(_sessionKey);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      // Save background time
      await prefs.setInt(_sessionKey, DateTime.now().millisecondsSinceEpoch);
    } else if (state == AppLifecycleState.resumed) {
      final lastTime = prefs.getInt(_sessionKey);
      if (lastTime != null) {
        final lastDateTime = DateTime.fromMillisecondsSinceEpoch(lastTime);
        final durationAway = DateTime.now().difference(lastDateTime);
        
        if (durationAway > widget.timeoutDuration) {
          _handleSessionTimeout();
        }
        
        // Reset
        await prefs.remove(_sessionKey);
      }
    }
  }

  Future<void> _handleSessionTimeout() async {
    final l10n = AppLocalizations.of(context);
    
    // 1. Perform Logout
    await AuthService.logout();

    // 2. Clear navigation and go to Login Screen
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
      
      // 3. Show feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.sessionExpired),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.orangeAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
