import 'package:flutter/material.dart';
import 'package:reel/core/routes/routes_name.dart';
import 'package:reel/core/services/navigation_service.dart';
import 'package:reel/core/services/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () =>
              getIt<NavigationService>().navigateTo(RoutesName.profile),
          child: Text("data"),
        ),
      ),
    );
  }
}
