part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AuthLogInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLogInEvent({
    required this.email,
    required this.password,
  });
}

final class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;

  AuthRegisterEvent({
    required this.email,
    required this.password,
  });
}

final class AuthGoogleSignInEvent extends AuthEvent {}

final class AuthResetEvent extends AuthEvent {}
