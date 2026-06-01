import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrape_application/core/utils/loaderHelper.dart';
import 'package:scrape_application/core/utils/redirectionHelper.dart';
import 'package:scrape_application/features/auth/screens/login_screen.dart';
import 'package:scrape_application/features/inventory/services/local_inventory_service.dart';
import 'package:scrape_application/features/inventory/services/online_inventory_service.dart';
import 'package:scrape_application/features/scan/models/scan_model.dart';

class InventoryController extends ChangeNotifier {
  List<ScanModel> onlineScans = [];
  List<ScanModel> localScans = [];

  bool isLoading = false;
  final onlineInventoryService = OnlineInventoryService();
  final localInventoryService = LocalInventoryService();

  Future<void> getOnlineScans({required BuildContext context}) async {
    try {
      debugPrint("Method Called");

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

  Future<void> getLocalScans() async {
    try {
      localScans = await localInventoryService.getLocalScans();
      debugPrint("Local Data Length: ${localScans.length}");
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
