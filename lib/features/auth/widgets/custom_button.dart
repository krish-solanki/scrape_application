import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

Widget buildButton({
  required BuildContext context,
  required String text,
  required VoidCallback? onPressed,
}) {
  return SizedBox(
    width: double.infinity,
    height: 48.h,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.highlight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.button.copyWith(
          fontSize: 15.sp,
        ),
      ),
    ),
  );
}