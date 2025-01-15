// ignore: depend_on_referenced_packages

import 'package:get_it/get_it.dart';
import 'package:reel/core/local_storage/hive_data.dart';
import 'package:reel/core/local_storage/shared_pred_data.dart';
import 'package:reel/core/services/hive_cache_service.dart';
import 'package:reel/core/services/navigation_service.dart';
import 'package:reel/core/services/shared_pref_service.dart';
import 'package:reel/feature/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:reel/feature/profile/presentation/cubit/profile_cubit.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<SharedPrefsServices>(SharedPrefsServices());
  getIt.registerSingleton<HiveCacheService>(HiveCacheService());
  getIt.registerSingleton<AbsSharedPrefData>(SharedPrefDataImpl());
  getIt.registerSingleton<HiveData>(HiveDataImpl());

  getIt.registerSingleton<AuthBloc>(AuthBloc());
  getIt.registerSingleton<ProfileCubit>(ProfileCubit());
}
