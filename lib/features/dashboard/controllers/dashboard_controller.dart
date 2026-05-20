import 'package:flutter/material.dart';
import 'package:scrape_application/features/auth/models/user_model.dart';
import 'package:scrape_application/features/dashboard/services/dashboard_service.dart';

class DashboardController extends ChangeNotifier{
    final DashboardService dashboardService = DashboardService();
  UserModel? user;

  bool isLoading = true;

  Future<void> getUserData() async {
    try {
      isLoading = true;
      notifyListeners();
      user = await dashboardService.getUserData();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}