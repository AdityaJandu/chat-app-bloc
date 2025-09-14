part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

// INITIAL STATE:
final class AuthInitial extends AuthState {}

// LOADING STATE:
final class AuthLoading extends AuthState {}

// AUTHENTICATED STATE:
final class Authenticated extends AuthState {
  final AppUser appUser;

  Authenticated(this.appUser);
}

// UNAUTHENTICATED STATE:
final class Unauthenticated extends AuthState {}

// AUTH ERROR STATE:
final class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

// Password reset state:
final class AuthPasswordResetEmailSent extends AuthState {
  final String email;
  AuthPasswordResetEmailSent(this.email);
}
