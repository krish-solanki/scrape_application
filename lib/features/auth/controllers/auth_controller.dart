import 'package:flutter/material.dart';
import 'package:scrape_application/core/utils/loaderHelper.dart';
import 'package:scrape_application/features/auth/screens/login_screen.dart';
import 'package:scrape_application/features/auth/services/auth_service.dart';
import 'package:scrape_application/shared/widgets/bottom_nav_bar.dart';

class AuthController extends ChangeNotifier {
  final AuthService authService = AuthService();

  bool isLoading = false;

  Future<void> register({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required bool isChecked,
  }) async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showMessage(context, "Please fill all fields");
      return;
    }

    if (password != confirmPassword) {
      showMessage(context, "Passwords do not match");
      return;
    }

    if (!isChecked) {
      showMessage(
        context,
        "Please accept terms & conditions",
      );
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      LoaderHelper.show(context);

      await authService.registerUser(
        name: name,
        email: email,
        password: password,
      );

      LoaderHelper.hide(context);

      showMessage(
        context,
        "Registration Successful",
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      LoaderHelper.hide(context);

      showMessage(context, e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      showMessage(
        context,
        "Please fill all details",
      );
      return;
    }

    try {
      isLoading = true;
      notifyListeners();
      LoaderHelper.show(context);

      await authService.loginUser(
        email: email,
        password: password,
      );

      LoaderHelper.hide(context);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const AppBottomNav(),
        ),
        (route) => false,
      );
    } catch (e) {
      LoaderHelper.hide(context);

      showMessage(context, e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}