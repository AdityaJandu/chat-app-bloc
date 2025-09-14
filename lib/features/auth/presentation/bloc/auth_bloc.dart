import 'package:chat_app_bloc/features/auth/domain/entities/app_user.dart';
import 'package:chat_app_bloc/features/auth/domain/repos/auth_repo.dart';
import 'package:chat_app_bloc/features/auth/domain/repos/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepo userRepo;
  final AuthRepo authRepo;
  AuthBloc({required this.authRepo, required this.userRepo})
      : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthCheckStatusRequested>(_checkStatus);
    on<AuthSignUpRequested>(_signUpRequested);
    on<AuthLogoutRequested>(_logOutRequested);
    on<AuthPasswordResetRequested>(_passwordResetRequested);
    on<AuthDeleteAccountRequested>(_deleteAccountRequested);
  }

  // Delete app user:
  Future<void> _deleteAccountRequested(
    AuthDeleteAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Get current user:
      final user = await authRepo.getCurrentUser();

      if (user == null) {
        emit(AuthError('No user found'));
        return;
      }

      String uid = user.uid;

      await authRepo.deleteAccount();
      await userRepo.deleteAppUser(uid);

      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError('Error: ${e.toString()}'));
    }
  }

  // Forgot password request:
  Future<void> _passwordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Get email from event:
      final String email = event.email;

      // Try to send the link:
      await authRepo.sendPasswordResetEmail(email);

      // Suceeded to sent that:
      emit(AuthPasswordResetEmailSent(email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Log out requested:
  Future<void> _logOutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepo.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // On Sign-Up requested:
  Future<void> _signUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Create an user:
      final user = await authRepo.signUpWithEmailAndPassword(
          event.email, event.password);

      // if user is null return:
      if (user == null) {
        emit(AuthError("Try again user wasn't created..."));
        return;
      }

      // Create app user:
      final appUser =
          AppUser(uid: user.uid, email: user.email, name: event.name);

      // Add app user in firebase:
      await userRepo.createAppUser(appUser);

      // its authenticated:
      emit(Authenticated(appUser));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // In _checkStatus
  Future<void> _checkStatus(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // 1. Get the basic auth user
      final authUser = await authRepo.getCurrentUser();
      if (authUser == null) {
        emit(Unauthenticated());
        return;
      }
      // 2. Fetch the full user profile from your database
      final fullAppUser = await userRepo.getAppUser(authUser.uid);

      // 3. Emit Authenticated with the full profile
      if (fullAppUser != null) {
        emit(Authenticated(fullAppUser));
      } else {
        // This indicates a data integrity issue (auth user exists but no DB record)
        // You could sign them out and emit Unauthenticated or show an error
        await authRepo.signOut();
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // On Login Requested:
  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Signin with auth repo:
      final tempUser = await authRepo.signInWithEmailAndPassword(
          event.email, event.password);

      // If user is NULL:
      if (tempUser == null) {
        emit(AuthError('No user found'));
        return;
      }

      // Fetch full profile from Firestore
      final fullUser = await userRepo.getAppUser(tempUser.uid);

      if (fullUser == null) {
        emit(AuthError('User profile not found. Please contact support.'));
        return;
      }

      emit(Authenticated(fullUser));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }
}
