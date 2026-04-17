import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

Widget buildListview() {
  return Container(
    margin: EdgeInsets.only(bottom: 12.h),
    padding: EdgeInsets.all(10.w),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Row(
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(Icons.inventory_2, color: AppColors.primary),
        ),

        SizedBox(width: 12.w),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Stainless Steel 304 Offcut", style: AppTextStyles.subHeading),
            SizedBox(height: 4.h),
            Text("34 Stramgs", style: AppTextStyles.body),
          ],
        ),

        Spacer(),

        Row(
          children: [
            Icon(Icons.thumb_up, color: AppColors.primary, size: 18.sp),
            SizedBox(width: 8.w),
            Icon(Icons.thumb_down, color: AppColors.textSecondary, size: 18.sp),
          ],
        ),
      ],
    ),
  );
}
