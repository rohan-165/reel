import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reel/core/bloc/app_open_cubit.dart';
import 'package:reel/core/bloc/internet_cubit.dart';
import 'package:reel/core/routes/route_generator.dart';
import 'package:reel/core/services/hive_cache_service.dart';
import 'package:reel/core/services/navigation_service.dart';
import 'package:reel/core/services/shared_pref_service.dart';
import 'package:reel/core/utils/app_toast.dart';
import 'package:reel/entry_screen.dart';
import 'package:reel/feature/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:reel/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:reel/feature/reel/presentation/reel_bloc/reel_bloc.dart';
import 'package:reel/feature/widget/internet_connection_widget.dart';

import 'core/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the service manager and Local Storage
  await setupLocator().then((value) {
    getIt<SharedPrefsServices>().init();
    getIt<HiveCacheService>().initCacheService();
  });

  /// Firebase initialization
  await Firebase.initializeApp();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  DateTime? _currentBackPressTime;
  final ValueNotifier<bool> _isToHide = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>.value(
          value: getIt<InternetCubit>(),
        ),
        BlocProvider<AppOpenCubit>.value(
          value: getIt<AppOpenCubit>(),
        ),
        BlocProvider<AuthBloc>.value(
          value: getIt<AuthBloc>(),
        ),
        BlocProvider<ProfileCubit>.value(
          value: getIt<ProfileCubit>(),
        ),
        BlocProvider<ReelBloc>.value(
          value: getIt<ReelBloc>(),
        ),
      ],
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
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              Expanded(
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
                          home: EntryScreen(),
                          title: 'Reel App',
                        ),
                      ),
                    );
                  },
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: _isToHide,
                  builder: (_, isToHide, __) {
                    return BlocBuilder<AppOpenCubit, bool>(
                      builder: (context, appOpenState) {
                        return InternetConnectionWidget(
                          callBack: (isConnected) {
                            if (isConnected) {
                              if (appOpenState) {
                                _isToHide.value = true;
                              } else {
                                // Call your method after 3 seconds
                                Future.delayed(Duration(seconds: 3), () {
                                  // Set showWidget to true after 3 seconds
                                  _isToHide.value = true;
                                });
                              }
                            } else {
                              _isToHide.value = false;
                            }
                          },
                          offlineWidget: Align(
                            alignment: Alignment.bottomCenter,
                            child: InternetConnectionMsgWidget(
                              isConnected: false,
                            ),
                          ),
                          onlineWidget: Align(
                            alignment: Alignment.bottomCenter,
                            child: isToHide
                                ? SizedBox.fromSize()
                                : InternetConnectionMsgWidget(
                                    isConnected: true,
                                  ),
                          ),
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
