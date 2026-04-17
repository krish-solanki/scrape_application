import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

Widget buildNavTab(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: AppColors.border),
    ),
    child: Row(
      children: [
        Text(text, style: AppTextStyles.body),
        SizedBox(width: 1.w),
        Icon(
          Icons.keyboard_arrow_down,
          size: 16.sp,
          color: AppColors.textSecondary,
        ),
      ],
    ),
  );
}
