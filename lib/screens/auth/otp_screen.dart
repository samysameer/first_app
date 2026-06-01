import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart' as auth_service;
import '../donor/donor_main_screen.dart';
import '../requester/requester_main_screen.dart';

class OtpScreen extends StatefulWidget {
  final auth_service.AuthUser user;

  const OtpScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  bool _isLoading = false;
  String? _verificationId;

  @override
  void initState() {
    super.initState();
    _sendOtp();
  }

  String? _formatEgyptianPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) return null;

    // Remove whitespace and dashes
    var cleanNumber = phoneNumber.trim().replaceAll(RegExp(r'[\s\-]+'), '');

    if (cleanNumber.startsWith('+20')) {
      return cleanNumber.length == 13 ? cleanNumber : null;
    }

    if (cleanNumber.startsWith('0020')) {
      return cleanNumber.length == 14 ? '+20${cleanNumber.substring(4)}' : null;
    }

    if (cleanNumber.startsWith('0')) {
      if (cleanNumber.length == 11) {
        return '+20${cleanNumber.substring(1)}';
      }
    }

    if (cleanNumber.length == 10 &&
        (cleanNumber.startsWith('10') ||
         cleanNumber.startsWith('11') ||
         cleanNumber.startsWith('12') ||
         cleanNumber.startsWith('15'))) {
      return '+20$cleanNumber';
    }

    return null;
  }

  Future<void> _sendOtp() async {
    final rawPhone = widget.user.phone;
    final formattedPhone = _formatEgyptianPhoneNumber(rawPhone);
    
    if (formattedPhone == null) {
      _showSnackBar('Invalid phone number format: $rawPhone. Please update your profile.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically verifies on some devices (Android)
          _navigateToHome();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (mounted) {
            setState(() { _isLoading = false; });
            _showSnackBar('Verification Failed: ${e.message}');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          if (mounted) {
            setState(() {
              _verificationId = verificationId;
              _isLoading = false;
            });
            _showSnackBar('OTP Sent to $formattedPhone');
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (mounted) {
            _verificationId = verificationId;
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() { _isLoading = false; });
        _showSnackBar('Error: $e');
      }
    }
  }

  void _verifyOtp() async {
    final code = _otpController.text.trim();
    if (code.length < 6) {
      _showSnackBar('Enter a valid 6-digit OTP');
      return;
    }
    if (_verificationId == null) {
      _showSnackBar('Please wait for OTP to be sent.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Create the credential object locally
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );
      
      // 2. Actually verify the OTP over the network!
      // PhoneAuthProvider.credential() does NOT verify the code by itself.
      // We must authenticate with Firebase to check if the OTP is correct.
      final user = FirebaseAuth.instance.currentUser;
      
      if (user != null) {
        try {
          // Link the phone credential to the current email user.
          // This throws an exception if the OTP is wrong.
          await user.linkWithCredential(credential);
        } on FirebaseAuthException catch (e) {
          // If the phone number is already linked to an account, linking will fail,
          // but we can verify the OTP by simply signing in with it.
          if (e.code == 'credential-already-in-use' || e.code == 'provider-already-linked') {
            await FirebaseAuth.instance.signInWithCredential(credential);
          } else {
            rethrow; // It's an invalid OTP or another error
          }
        }
      } else {
        // Fallback if the user is null
        await FirebaseAuth.instance.signInWithCredential(credential);
      }

      // If we reach here, the OTP was successfully verified by Firebase!
      if (mounted) {
        _navigateToHome();
      }

    } catch (e) {
      if (mounted) {
        setState(() { _isLoading = false; });
        _showSnackBar('Invalid OTP Code. Please try again.');
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _navigateToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return widget.user.userType == auth_service.UserType.donor
              ? const DonorMainScreen()
              : const RequesterMainScreen();
        },
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Two-Step Verification'),
        backgroundColor: const Color(0xFFDC2626),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.message_outlined,
              size: 64,
              color: Color(0xFFDC2626),
            ),
            const SizedBox(height: 24),
            Text(
              'Enter the OTP sent to\n${widget.user.phone ?? "your phone"}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, letterSpacing: 8.0),
              decoration: InputDecoration(
                hintText: '000000',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFDC2626), width: 2),
                ),
              ),
              maxLength: 6,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Verify & Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
