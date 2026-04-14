import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

Widget buildButton({
  required BuildContext context,

  required String text,
  required VoidCallback? onPressed,
}) {
  final theme = Theme.of(context);

  return SizedBox(
    width: double.infinity,
    height: 45.h,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.secondary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(text, style: AppTextStyles.button),
    ),
  );
}
