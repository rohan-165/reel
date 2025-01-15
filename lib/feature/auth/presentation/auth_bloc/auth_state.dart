part of 'auth_bloc.dart';

sealed class AuthState {
  final AbsNormalStatus loginStatus;
  final UserModel userModel;
  final String message;

  const AuthState({
    required this.loginStatus,
    required this.userModel,
    required this.message,
  });

  AuthState copyWith({
    AbsNormalStatus? loginStatus,
    UserModel? userModel,
    String? message,
  }) {
    return AuthStateImpl(
      loginStatus: loginStatus ?? this.loginStatus,
      userModel: userModel ?? this.userModel,
      message: message ?? this.message,
    );
  }
}

final class AuthStateImpl extends AuthState {
  const AuthStateImpl({
    required super.loginStatus,
    required super.userModel,
    required super.message,
  });

  @override
  AuthStateImpl copyWith({
    AbsNormalStatus? loginStatus,
    UserModel? userModel,
    String? message,
  }) {
    return AuthStateImpl(
      loginStatus: loginStatus ?? this.loginStatus,
      userModel: userModel ?? this.userModel,
      message: message ?? this.message,
    );
  }
}

final class AuthInitial extends AuthStateImpl {
  AuthInitial()
      : super(
          loginStatus: AbsNormalStatus.INITIAL,
          userModel: UserModel(),
          message: '',
        );
}
