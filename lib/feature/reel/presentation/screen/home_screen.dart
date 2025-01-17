import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reel/core/services/service_locator.dart';
import 'package:reel/core/utils/app_toast.dart';
import 'package:reel/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:reel/feature/profile/presentation/screen/profile_screen.dart';
import 'package:reel/feature/reel/presentation/screen/reel_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> _navIndex = ValueNotifier<int>(0);
  DateTime? _currentBackPressTime;
  @override
  void initState() {
    getIt<ProfileCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
      child: ValueListenableBuilder(
          valueListenable: _navIndex,
          builder: (_, index, __) {
            return Scaffold(
              body: _view(index: index),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: index,
                onTap: (value) => _navIndex.value = value,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _view({required int index}) {
    switch (index) {
      case 0:
        return ReelView();
      case 1:
        return ProfileScreen();
      default:
        return ProfileScreen();
    }
  }
}
