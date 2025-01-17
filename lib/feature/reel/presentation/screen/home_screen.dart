import 'package:flutter/material.dart';
import 'package:reel/feature/profile/presentation/screen/profile_screen.dart';
import 'package:reel/feature/reel/presentation/screen/reel_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> _navIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
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
        });
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
