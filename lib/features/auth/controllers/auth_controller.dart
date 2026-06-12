import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrape_application/core/utils/loaderHelper.dart';
import 'package:scrape_application/core/utils/redirectionHelper.dart';
import 'package:scrape_application/features/auth/screens/login_screen.dart';
import 'package:scrape_application/features/auth/services/auth_service.dart';
import 'package:scrape_application/shared/widgets/bottom_nav_bar.dart';

class AuthController extends ChangeNotifier {
  final AuthService authService = AuthService();
  static String? userId;
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
      showMessage(context, "Please accept terms & conditions");
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
      showMessage(context, "Registration Successful");
      PageRedirectionHelper.popScreenRedirection(
        context: context,
        widget: LoginScreen(),
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
      showMessage(context, "Please fill all details");
      return;
    }

    try {
      isLoading = true;
      notifyListeners();
      LoaderHelper.show(context);
      await authService.loginUser(email: email, password: password);
      LoaderHelper.hide(context);
      userId = FirebaseAuth.instance.currentUser!.uid;
      PageRedirectionHelper.popScreenRedirection(
        context: context,
        widget: AppBottomNav(),
      );
    } catch (e) {
      LoaderHelper.hide(context);
      showMessage(context, e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout({required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      LoaderHelper.show(context);
      await FirebaseAuth.instance.signOut();
      userId = null;
      notifyListeners();
      LoaderHelper.hide(context);
      PageRedirectionHelper.popScreenRedirection(
        context: context,
        widget: LoginScreen(),
      );
    } catch (e) {
      if (isLoading) {
        LoaderHelper.hide(context);
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> isLoggedIn({required BuildContext context}) async {
    debugPrint('Method Called');
    if (userId == null) {
      logout(context: context);
    }
  }
}