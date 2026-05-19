import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrape_application/core/constants/app_loader.dart';
import 'package:scrape_application/core/utils/redirectionHelper.dart';
import 'package:scrape_application/features/auth/screens/login_screen.dart';
import 'package:scrape_application/shared/widgets/bottom_nav_bar.dart';

class SessionCheckerScreen extends StatefulWidget {
  const SessionCheckerScreen({super.key});

  @override
  State<SessionCheckerScreen> createState() => _SessionCheckerScreenState();
}

class _SessionCheckerScreenState extends State<SessionCheckerScreen> {
  @override
  void initState() {
    super.initState();

    checkSession();
  }

  Future<void> checkSession() async {
    await Future.delayed(const Duration(seconds: 1));

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      PageRedirectionHelper.popScreenRedirection(
        context: context,
        widget: AppBottomNav(),
      );
    } else {
      PageRedirectionHelper.popScreenRedirection(
        context: context,
        widget: LoginScreen(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: AppLoader()));
  }
}
