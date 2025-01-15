import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reel/core/local_storage/hive_data.dart';
import 'package:reel/core/services/service_locator.dart';
import 'package:reel/feature/auth/domain/model/user_model.dart';

class ProfileCubit extends Cubit<UserModel> {
  ProfileCubit() : super(UserModel());

  void getUserData() async {
    UserModel? user = await getIt<HiveData>().getUserDetail();
    emit(user ?? UserModel());
  }

  void reset() {
    emit(UserModel());
  }
}
