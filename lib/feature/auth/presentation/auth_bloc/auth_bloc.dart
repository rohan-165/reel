import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reel/core/constants/enum.dart';
import 'package:reel/core/local_storage/hive_data.dart';
import 'package:reel/core/local_storage/shared_pred_data.dart';
import 'package:reel/core/routes/routes_name.dart';
import 'package:reel/core/services/navigation_service.dart';
import 'package:reel/core/services/service_locator.dart';
import 'package:reel/feature/auth/data/auth_mixin.dart';
import 'package:reel/feature/auth/domain/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with AuthMixin {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    /// Authentication Reset state
    on<AuthResetEvent>((event, emit) {
      emit(AuthInitial());
    });

    /// User Login state
    on<AuthLogInEvent>((event, emit) async {
      emit(state.copyWith(
        loginStatus: AbsNormalStatus.LOADING,
      ));
      await emailAndPassword(
          mode: AuthMode.LOGIN,
          email: event.email,
          password: event.password,
          callBack: ({
            required message,
            required status,
          }) {
            emit(
              state.copyWith(
                loginStatus: status,
                userModel: UserModel(
                  email: event.email,
                ),
                message: message,
              ),
            );
            if (status == AbsNormalStatus.SUCCESS) {
              getIt<AbsSharedPrefData>().setToken(value: event.email);
              getIt<HiveData>().saveUserDetail(
                  userModel: UserModel(
                email: event.email,
              ));
              getIt<NavigationService>()
                  .pushNamedAndRemoveUntil(RoutesName.home, false);
            }
          });
    });

    /// User Register state
    on<AuthRegisterEvent>((event, emit) async {
      emit(state.copyWith(
        loginStatus: AbsNormalStatus.LOADING,
      ));
      await emailAndPassword(
          mode: AuthMode.REGISTER,
          email: event.email,
          password: event.password,
          callBack: ({
            required message,
            required status,
          }) {
            emit(
              state.copyWith(
                loginStatus: status,
                userModel: UserModel(
                  email: event.email,
                ),
                message: message,
              ),
            );
            if (status == AbsNormalStatus.SUCCESS) {
              getIt<AbsSharedPrefData>().setToken(value: event.email);
              getIt<HiveData>().saveUserDetail(
                  userModel: UserModel(
                email: event.email,
              ));
              getIt<NavigationService>()
                  .pushNamedAndRemoveUntil(RoutesName.home, false);
            }
          });
    });

    /// User Google Signin state
    on<AuthGoogleSignInEvent>((event, emit) async {
      emit(state.copyWith(
        loginStatus: AbsNormalStatus.LOADING,
      ));
      // Authenticate with Google API and emit AuthSuccess or AuthFailure event
      await signInWithGoogle(callBack: ({
        required message,
        required status,
        required userModel,
      }) {
        emit(
          state.copyWith(
            loginStatus: status,
            userModel: userModel,
            message: message,
          ),
        );
        if (status == AbsNormalStatus.SUCCESS) {
          getIt<AbsSharedPrefData>().setToken(value: userModel.email ?? '');
          getIt<HiveData>().saveUserDetail(userModel: userModel);
          getIt<NavigationService>()
              .pushNamedAndRemoveUntil(RoutesName.home, false);
        }
      });
    });
  }
}
