part of 'auth_bloc.dart';

sealed class AuthState {
  final AbsNormalStatus loginStatus;
  final bool isGoogleAuth;
  final UserModel userModel;
  final String message;

  const AuthState({
    required this.loginStatus,
    required this.isGoogleAuth,
    required this.userModel,
    required this.message,
  });

  AuthState copyWith({
    AbsNormalStatus? loginStatus,
    bool? isGoogleAuth,
    UserModel? userModel,
    String? message,
  }) {
    return AuthStateImpl(
      loginStatus: loginStatus ?? this.loginStatus,
      isGoogleAuth: isGoogleAuth ?? this.isGoogleAuth,
      userModel: userModel ?? this.userModel,
      message: message ?? this.message,
    );
  }
}

final class AuthStateImpl extends AuthState {
  const AuthStateImpl({
    required super.loginStatus,
    required super.userModel,
    required super.isGoogleAuth,
    required super.message,
  });

  @override
  AuthStateImpl copyWith({
    AbsNormalStatus? loginStatus,
    UserModel? userModel,
    bool? isGoogleAuth,
    String? message,
  }) {
    return AuthStateImpl(
      loginStatus: loginStatus ?? this.loginStatus,
      userModel: userModel ?? this.userModel,
      message: message ?? this.message,
      isGoogleAuth: isGoogleAuth ?? this.isGoogleAuth,
    );
  }
}

final class AuthInitial extends AuthStateImpl {
  AuthInitial()
      : super(
          loginStatus: AbsNormalStatus.INITIAL,
          userModel: UserModel(),
          message: '',
          isGoogleAuth: false,
        );
}
