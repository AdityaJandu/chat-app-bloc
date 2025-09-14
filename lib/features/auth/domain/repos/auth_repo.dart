/*

AUTH REPOSITORY
=> Outlines all possible auth operation.

*/

import 'package:chat_app_bloc/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> signInWithEmailAndPassword(String email, String password);
  Future<AppUser?> signUpWithEmailAndPassword(String email, String password);

  Future<void> signOut();
  Future<AppUser?> getCurrentUser();
  Future<String> sendPasswordResetEmail(String email);
  Future<void> deleteAccount();
}
