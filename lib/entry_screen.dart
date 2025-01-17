import 'package:flutter/material.dart';
import 'package:reel/core/local_storage/shared_pred_data.dart';
import 'package:reel/core/services/service_locator.dart';
import 'package:reel/feature/auth/presentation/screen/login_screen.dart';
import 'package:reel/feature/reel/presentation/screen/home_screen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  String? token;

  @override
  void initState() {
    super.initState();
    token = getIt<AbsSharedPrefData>().getToken;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return token != null ? const HomeScreen() : const LoginScreen();
  }
}
