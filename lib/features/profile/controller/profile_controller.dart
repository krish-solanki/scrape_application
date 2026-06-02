import 'package:flutter/material.dart';
import 'package:scrape_application/core/utils/loaderHelper.dart';
import 'package:scrape_application/features/auth/models/user_model.dart';
import 'package:scrape_application/features/profile/services/profile_service.dart';

class ProfileController extends ChangeNotifier {
  final ProfileService profileService = ProfileService();
  UserModel? user;
  bool isLoading = true;

  Future<void> getUserData() async {
    try {
      isLoading = true;
      notifyListeners();
      user = await profileService.getUserData();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile({
    required BuildContext context,
    required String name,
    required String phone,
    required String image,
  }) async {
    try {
      if (name.isEmpty || phone.isEmpty) {
        throw "All fields are required";
      }

      if (phone.length != 10) {
        throw "Phone number must be 10 digits";
      }

      isLoading = true;
      notifyListeners();

      LoaderHelper.show(context);

      await profileService.updateProfile(
        name: name,
        phone: phone,
        image: image,
      );

      await getUserData();

      LoaderHelper.hide(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated Successfully")),
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
}
