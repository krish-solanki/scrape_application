import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

Widget buildRowButton({
  required BuildContext context,
  required String text,
  required Color color,
  required VoidCallback? onPressed,
}) {
  return SizedBox(
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      child: Text(text, style: AppTextStyles.button.copyWith(fontSize: 15.sp)),
    ),
  );
}
