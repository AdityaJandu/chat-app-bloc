part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// Check Status:
final class AuthCheckStatusRequested extends AuthEvent {}

// When login is requested:
final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequested({
    required this.email,
    required this.password,
  });
}

// When Logout is requested:
final class AuthLogoutRequested extends AuthEvent {}

// When user sign up is requested:
final class AuthSignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUpRequested({
    required this.name,
    required this.email,
    required this.password,
  });
}

// Triggered when user requests password reset
final class AuthPasswordResetRequested extends AuthEvent {
  final String email;

  AuthPasswordResetRequested({required this.email});
}

//  Triggered when user wants to delete account
final class AuthDeleteAccountRequested extends AuthEvent {}
