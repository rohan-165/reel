part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AuthLogInEvent extends AuthEvent {
  final String email;
  final String password;
  final bool isGoogleAuth;

  AuthLogInEvent({
    required this.email,
    required this.password,
    required this.isGoogleAuth,
  });
}

final class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final bool isGoogleAuth;

  AuthRegisterEvent({
    required this.email,
    required this.password,
    required this.isGoogleAuth,
  });
}

final class AuthGoogleSignInEvent extends AuthEvent {
  final bool isGoogleAuth;

  AuthGoogleSignInEvent({required this.isGoogleAuth});
}

final class AuthResetEvent extends AuthEvent {}
