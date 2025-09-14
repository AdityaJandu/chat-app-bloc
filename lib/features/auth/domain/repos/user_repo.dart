/*

User REPOSITORY
=> Outlines all possible user operation.

*/

import 'package:chat_app_bloc/features/auth/domain/entities/app_user.dart';

abstract class UserRepo {
  Future<void> createAppUser(AppUser appUser);
  Future<void> updateAppUser(AppUser appUser);
  Future<AppUser?> getAppUser(String uid);
  Future<void> deleteAppUser(String uid);
}
