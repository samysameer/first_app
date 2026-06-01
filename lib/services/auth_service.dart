import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

enum UserType { donor, requester }

/// A simple class to represent a user in the application.
class AuthUser {
  final String uid;
  final String email;
  final UserType userType;
  final String? name;
  final String? phone;
  final String? bloodType;
  final String? city;
  final bool isAvailable;

  const AuthUser({
    required this.uid,
    required this.email,
    required this.userType,
    this.name,
    this.phone,
    this.bloodType,
    this.city,
    this.isAvailable = true,
  });
}

/// A wrapper class for authentication results.
class AuthResult {
  final AuthUser? user;
  final String? error;

  const AuthResult({this.user, this.error});

  bool get success => user != null;
}

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Uploads a profile image and returns its URL.
  static Future<String?> uploadProfileImage(File imageFile) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final ref = _storage.ref().child('profile_images').child('${user.uid}.jpg');
      await ref.putFile(imageFile);
      final url = await ref.getDownloadURL();

      // Update Firestore
      await _firestore.collection('users').doc(user.uid).update({'photoUrl': url});
      return url;
    } catch (e) {
      debugPrint('AuthService: Upload Image Error: $e');
      return null;
    }
  }

  /// Registers a new user with Firebase Auth and creates a profile in Firestore.
  static Future<AuthResult> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required UserType userType,
    String? bloodType,
    String? city,
  }) async {
    try {
      final String cleanEmail = email.trim().toLowerCase();
      final String cleanPassword = password.trim();

      if (cleanEmail.isEmpty || cleanPassword.isEmpty) {
        return const AuthResult(error: 'Email and password are required.');
      }

      // 1. Create user in Firebase Authentication
      final credential = await _auth.createUserWithEmailAndPassword(
        email: cleanEmail,
        password: cleanPassword,
      );

      final user = credential.user;
      if (user == null) {
        return const AuthResult(error: 'Registration failed. No user returned.');
      }

      // 2. Send Email Verification (Production Best Practice)
      await user.sendEmailVerification();

      // 3. Save additional user profile data to Firestore
      final userData = {
        'name': name.trim(),
        'email': cleanEmail,
        'phone': phone.trim(),
        'userType': userType.name,
        'isAvailable': true, // Default to available
        'createdAt': FieldValue.serverTimestamp(),
      };
      
      if (bloodType != null) userData['bloodType'] = bloodType;
      if (city != null) userData['city'] = city;

      await _firestore.collection('users').doc(user.uid).set(userData);

      return AuthResult(
        user: AuthUser(
          uid: user.uid,
          email: user.email ?? cleanEmail,
          userType: userType,
          name: name.trim(),
          phone: phone.trim(),
          bloodType: bloodType,
          city: city,
          isAvailable: true,
        ),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('AuthService: Firebase Auth Exception [${e.code}]: ${e.message}');
      return AuthResult(error: _mapAuthErrorMessage(e));
    } catch (e) {
      debugPrint('AuthService: Unexpected Register Error: $e');
      return const AuthResult(error: 'An unexpected error occurred. Please try again.');
    }
  }

  /// Authenticates an existing user and retrieves their profile.
  static Future<AuthResult> login(String email, String password) async {
    try {
      final String cleanEmail = email.trim().toLowerCase();
      final String cleanPassword = password.trim();

      if (cleanEmail.isEmpty || cleanPassword.isEmpty) {
        return const AuthResult(error: 'Please enter both email and password.');
      }

      // 1. Sign in with Firebase Authentication
      final credential = await _auth.signInWithEmailAndPassword(
        email: cleanEmail,
        password: cleanPassword,
      );

      final user = credential.user;
      if (user == null) {
        return const AuthResult(error: 'Login failed. No user returned.');
      }

      // 2. Check if Email is Verified (Fact Checking)
      if (!user.emailVerified) {
        return const AuthResult(
          error: 'Please verify your email before logging in. Check your inbox for the link.',
        );
      }

      // 3. Fetch user profile from Firestore
      final snapshot = await _firestore.collection('users').doc(user.uid).get();
      if (!snapshot.exists) {
        return const AuthResult(error: 'User profile not found in database.');
      }

      final data = snapshot.data();
      final result = AuthResult(
        user: AuthUser(
          uid: user.uid,
          email: user.email ?? cleanEmail,
          userType: _parseUserType(data?['userType']?.toString() ?? 'donor'),
          name: data?['name']?.toString(),
          phone: data?['phone']?.toString(),
          bloodType: data?['bloodType']?.toString(),
          city: data?['city']?.toString(),
          isAvailable: data?['isAvailable'] == true,
        ),
      );

      return result;
    } on FirebaseAuthException catch (e) {
      debugPrint('AuthService: Firebase Auth Exception [${e.code}]: ${e.message}');
      return AuthResult(error: _mapAuthErrorMessage(e));
    } on FirebaseException catch (e) {
      debugPrint('AuthService: Firebase Exception [${e.code}]: ${e.message}');
      return AuthResult(error: 'Database error: ${e.message}');
    } catch (e) {
      debugPrint('AuthService: Unexpected Login Error: $e');
      return AuthResult(error: 'Login failed: $e');
    }
  }

  /// Updates the availability status of the current user.
  static Future<bool> updateAvailability(bool status) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      await _firestore.collection('users').doc(user.uid).update({
        'isAvailable': status,
      });
      return true;
    } catch (e) {
      debugPrint('AuthService: Update Availability Error: $e');
      return false;
    }
  }

  /// Authenticates a user by phone number and password.
  static Future<AuthResult> loginWithPhone(String phone, String password) async {
    try {
      final String cleanPhone = phone.trim();
      final String cleanPassword = password.trim();

      if (cleanPhone.isEmpty || cleanPassword.isEmpty) {
        return const AuthResult(error: 'Please enter both phone number and password.');
      }

      // 1. Find the email associated with this phone number in Firestore
      final querySnapshot = await _firestore
          .collection('users')
          .where('phone', isEqualTo: cleanPhone)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return const AuthResult(error: 'No account found with this phone number.');
      }

      final userData = querySnapshot.docs.first.data();
      final String? email = userData['email']?.toString();

      if (email == null) {
        return const AuthResult(error: 'Account data is corrupted. Please contact support.');
      }

      // 2. Use the standard login method with the retrieved email
      return await login(email, cleanPassword);
    } catch (e) {
      debugPrint('AuthService: Phone Login Error: $e');
      return AuthResult(error: 'Phone login failed: ${e.toString()}');
    }
  }

  /// Signs out the current user.
  static Future<void> logout() async {
    await _auth.signOut();
  }

  /// Sends a password reset email to the specified address.
  static Future<String?> resetPassword(String email) async {
    try {
      final String cleanEmail = email.trim().toLowerCase();
      if (cleanEmail.isEmpty) {
        return 'Please enter your email address.';
      }

      await _auth.sendPasswordResetEmail(email: cleanEmail);
      return null; // Success
    } on FirebaseAuthException catch (e) {
      debugPrint('AuthService: Reset Password Error [${e.code}]: ${e.message}');
      switch (e.code) {
        case 'user-not-found':
          return 'No account found with this email address.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'too-many-requests':
          return 'Too many requests. Please try again later.';
        default:
          return _mapAuthErrorMessage(e);
      }
    } catch (e) {
      debugPrint('AuthService: Unexpected Reset Password Error: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Maps Firebase Auth error codes to user-friendly messages.
  static String _mapAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered. Please log in instead.';
      case 'weak-password':
        return 'The password is too weak. Please use at least 6 characters.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password. Please check your credentials.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }

  static UserType _parseUserType(String value) {
    switch (value) {
      case 'requester':
        return UserType.requester;
      case 'donor':
      default:
        return UserType.donor;
    }
  }
}
