/*

FIREBASE FIRESTORE REPO
=> All Firebase Auth related code:

*/
import 'package:chat_app_bloc/features/auth/domain/entities/app_user.dart';
import 'package:chat_app_bloc/features/auth/domain/repos/user_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreRepo extends UserRepo {
  // Get refernce of user collection:
  final _cloudFirestore = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> createAppUser(AppUser appUser) async {
    try {
      // Create:
      await _cloudFirestore.doc(appUser.uid).set(appUser.toMap());
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteAppUser(String uid) async {
    try {
      // Delete
      await _cloudFirestore.doc(uid).delete();
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  @override
  Future<AppUser?> getAppUser(String uid) async {
    try {
      // Get Document:
      final doc = await _cloudFirestore.doc(uid).get();

      // Checking if there is an document:
      if (!doc.exists) throw Exception('Error no user found');

      // Return app user:
      return AppUser.fromMap(doc.data()!);
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  @override
  Future<void> updateAppUser(AppUser appUser) async {
    try {
      // Update app user:
      await _cloudFirestore.doc(appUser.uid).update(appUser.toMap());
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
