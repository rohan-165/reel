import 'package:flutter/material.dart';
import 'package:reel/core/routes/routes_name.dart';
import 'package:reel/feature/auth/presentation/screen/login_screen.dart';
import 'package:reel/feature/reel/presentation/screen/home_screen.dart';
import 'package:reel/feature/profile/presentation/screen/profile_screen.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // Object? argument = settings.arguments;

    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginScreen(),
        );
      case RoutesName.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );

      case RoutesName.profile:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ProfileScreen(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const LoginScreen(),
        );
    }
  }
}
