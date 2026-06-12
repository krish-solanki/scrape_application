import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrape_application/core/utils/loaderHelper.dart';
import 'package:scrape_application/core/utils/redirectionHelper.dart';
import 'package:scrape_application/features/auth/models/user_model.dart';
import 'package:scrape_application/features/auth/screens/login_screen.dart';
import 'package:scrape_application/features/dashboard/services/dashboard_service.dart';
import 'package:scrape_application/features/scan/models/scan_model.dart';

class DashboardController extends ChangeNotifier {
  final DashboardService dashboardService = DashboardService();

  UserModel? user;

  bool isLoading = false;

  String selectedScan = 'Local';

  List<ScanModel> onlineScans = [];

  List<ScanModel> localScans = [];

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

  void changeMode(String value) {
    selectedScan = value;
    notifyListeners();
  }

  List<ScanModel> get displayScans {
    return selectedScan == 'Online' ? onlineScans : localScans;
  }

  List<ScanModel> get recentScans {
    return displayScans.take(5).toList();
  }

  Future<void> getOnlineScans({required BuildContext context}) async {
    LoaderHelper.show(context);

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        LoaderHelper.hide(context);

        PageRedirectionHelper.popScreenRedirection(
          context: context,
          widget: const LoginScreen(),
        );

        return;
      }

      onlineScans = await dashboardService.getOnlineScans(userId: user.uid);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      LoaderHelper.hide(context);
      notifyListeners();
    }
  }

  Future<void> getLocalScans({required BuildContext context}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        PageRedirectionHelper.popScreenRedirection(
          context: context,
          widget: const LoginScreen(),
        );
        return;
      }

      isLoading = true;
      notifyListeners();

      localScans = await dashboardService.getLocalScans();

      debugPrint("Local Data Length: ${localScans.length}");
    } catch (e) {
      debugPrint("Error Fetching Local Data: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  double get totalWeight {
    return displayScans.fold(0, (sum, scan) => sum + scan.weight);
  }

  double get totalValue {
    return displayScans.fold(0, (sum, scan) => sum + scan.totalPrice);
  }

  int get totalScans {
    return displayScans.length;
  }
}
