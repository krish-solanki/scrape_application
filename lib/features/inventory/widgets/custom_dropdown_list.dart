import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

Widget buildDropdownTab({
  required String value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.w),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: AppColors.border),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 16.sp,
          color: AppColors.textPrimary,
        ),
        dropdownColor: AppColors.surface,
        style: AppTextStyles.body,
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Center(child: Text(item)));
        }).toList(),
        onChanged: onChanged,
      ),
    ),
  );
}
