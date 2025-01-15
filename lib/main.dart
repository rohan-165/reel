import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reel/core/local_storage/shared_pred_data.dart';
import 'package:reel/core/routes/route_generator.dart';
import 'package:reel/core/routes/routes_name.dart';
import 'package:reel/core/services/hive_cache_service.dart';
import 'package:reel/core/services/navigation_service.dart';
import 'package:reel/core/services/shared_pref_service.dart';
import 'package:reel/core/utils/app_toast.dart';
import 'package:reel/feature/auth/presentation/auth_bloc/auth_bloc.dart';

import 'core/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the service manager and Local Storage
  await setupLocator().then((value) {
    getIt<SharedPrefsServices>().init();
    getIt<HiveCacheService>().initCacheService();
  });

  /// Firebase initialization
  Firebase.initializeApp();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  DateTime? _currentBackPressTime;

  /// Check if the user is  already Logged in or not
  String get initialRoute => getIt<AbsSharedPrefData>().getToken != null
      ? RoutesName.home
      : RoutesName.login;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>.value(
      value: getIt<AuthBloc>(),
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          DateTime now = DateTime.now();
          if (_currentBackPressTime == null ||
              now.difference(_currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            _currentBackPressTime = now;
            AppToasts().showToast(
              message: "Tap back again  to exit app.",
              backgroundColor: Colors.black,
            );
          } else {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          }
        },
        canPop: false,
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return Material(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  navigatorKey: NavigationService.navigatorKey,
                  onGenerateRoute: RouteGenerator.generateRoute,
                  initialRoute: initialRoute,
                  title: 'Reel App',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
