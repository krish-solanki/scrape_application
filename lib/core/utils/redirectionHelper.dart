import 'package:flutter/material.dart';
import 'package:scrape_application/core/utils/loaderHelper.dart';

class PageRedirectionHelper {
  static Future<void> popScreenRedirection({
    required BuildContext context,
    required Widget widget,
  }) async {
    LoaderHelper.show(context);
    await Future.delayed(const Duration(seconds: 2));
    LoaderHelper.hide(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
  }
}
