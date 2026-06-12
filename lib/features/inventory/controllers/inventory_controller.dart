import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrape_application/core/utils/loaderHelper.dart';
import 'package:scrape_application/core/utils/redirectionHelper.dart';
import 'package:scrape_application/features/auth/controllers/auth_controller.dart';
import 'package:scrape_application/features/auth/screens/login_screen.dart';
import 'package:scrape_application/features/inventory/services/local_inventory_service.dart';
import 'package:scrape_application/features/inventory/services/online_inventory_service.dart';
import 'package:scrape_application/features/scan/models/scan_model.dart';

class InventoryController extends ChangeNotifier {
  List<ScanModel> onlineScans = [];
  List<ScanModel> localScans = [];
  String selectedType = 'All';
  String selectedSource = 'Local';
  String selectedWeight = 'All';
  final authController = AuthController();

  bool isLoading = false;
  final onlineInventoryService = OnlineInventoryService();
  final localInventoryService = LocalInventoryService();

  Future<void> getOnlineScans({required BuildContext context}) async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        PageRedirectionHelper.popScreenRedirection(
          context: context,
          widget: LoginScreen(),
        );
        return;
      }

      isLoading = true;
      notifyListeners();

      LoaderHelper.show(context);

      debugPrint("Current UID: ${FirebaseAuth.instance.currentUser!.uid}");

      onlineScans = await onlineInventoryService.getOnlineScan(
        userId: FirebaseAuth.instance.currentUser!.uid,
      );

      debugPrint("Online Scans Length: ${onlineScans.length}");
    } catch (e) {
      debugPrint("Error Fetching Data: $e");
    } finally {
      isLoading = false;

      LoaderHelper.hide(context);

      notifyListeners();
    }
  }

  Future<void> getLocalScans({required BuildContext context}) async {
    try {
      await authController.isLoggedIn(context: context);
      localScans = await localInventoryService.getLocalScans();
      debugPrint("Local Data Length: ${localScans.length}");
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<ScanModel> get displayScans {
    List<ScanModel> scans = selectedSource == 'Online'
        ? onlineScans
        : localScans;

    if (selectedType != 'All') {
      scans = scans.where((scan) {
        return scan.scrapType.toLowerCase() == selectedType.toLowerCase();
      }).toList();
    }

    switch (selectedWeight) {
      case '0-10 Kg':
        scans = scans.where((e) => e.weight <= 10).toList();
        break;

      case '10-50 Kg':
        scans = scans.where((e) => e.weight > 10 && e.weight <= 50).toList();
        break;

      case '50-100 Kg':
        scans = scans.where((e) => e.weight > 50 && e.weight <= 100).toList();
        break;

      case '100+ Kg':
        scans = scans.where((e) => e.weight > 100).toList();
        break;
    }

    return scans;
  }

  void changeType(String value) {
    selectedType = value;
    notifyListeners();
  }

  Future<void> changeSource(String value, BuildContext context) async {
    selectedSource = value;
    if (value == 'Online') {
      await getOnlineScans(context: context);
    } else {
      await getLocalScans(context: context);
    }
    notifyListeners();
  }

  void changeWeight(String value) {
    selectedWeight = value;
    notifyListeners();
  }
}
