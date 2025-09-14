/*

FIREBASE AUTH REPO
=> All Firebase Auth related code:

*/

import 'package:chat_app_bloc/features/auth/domain/entities/app_user.dart';
import 'package:chat_app_bloc/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo extends AuthRepo {
  // Access firebase auth instance:
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Delete an existing account:
  @override
  Future<void> deleteAccount() async {
    try {
      // Get current user:
      final user = _firebaseAuth.currentUser;

      // Check if user exists:
      if (user == null) throw Exception('No user found');

      // Delete user:
      await user.delete();

      // Signout user:
      await signOut();
    } catch (e) {
      throw Exception('Registeration Failed: ${e.toString()}');
    }
  }

  // Get current user:
  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      // Get current user:
      final user = _firebaseAuth.currentUser!;

      // Create app user:
      final appUser = AppUser(uid: user.uid, email: user.email ?? "", name: '');

      // Return that app user:
      return appUser;
    } catch (e) {
      throw Exception('Registeration Failed: ${e.toString()}');
    }
  }

  // Send reset link on email:
  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return 'Password reset link send! Please check your inbox.';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  // Sign in using email and password:
  @override
  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // Attempt to login:
      UserCredential _userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user:
      AppUser appUser = AppUser(
        uid: _userCredential.user!.uid,
        email: email,
        name: '',
      );

      // Return app user:
      return appUser;
    } catch (e) {
      throw Exception('Registeration Failed: ${e.toString()}');
    }
  }

  // Log Out:
  @override
  Future<void> signOut() async {
    try {
      // Sign Out:
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Registeration Failed: ${e.toString()}');
    }
  }

  // Sign up user:
  @override
  Future<AppUser?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      // Attempt to create user:
      UserCredential _userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create App User:
      final appUser = AppUser(
        uid: _userCredential.user!.uid,
        email: email,
        name: '',
      );

      // return app user:
      return appUser;
    } catch (e) {
      throw Exception('Registeration Failed: ${e.toString()}');
    }
  }
}
