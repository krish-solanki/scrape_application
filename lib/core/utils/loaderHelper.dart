import 'package:flutter/material.dart';
import 'package:scrape_application/core/constants/app_loader.dart';

class LoaderHelper {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (context) {
        return const PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: AppLoader(),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}