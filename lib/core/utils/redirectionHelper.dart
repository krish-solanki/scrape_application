import 'package:flutter/material.dart';

class PageRedirectionHelper {
  static popScreenRedirection({required BuildContext context, required Widget widget}) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => widget),
      (route) => false,
    );
  }
}
