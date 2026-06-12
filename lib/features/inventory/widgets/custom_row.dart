import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

Widget buildRow(String name, String type, String weight, Color statusColor) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.h),
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: AppColors.border.withOpacity(0.4)),
    ),
    child: Row(
      children: [
        Container(
          width: 4.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),

        SizedBox(width: 10.w),

        Expanded(
          flex: 3,
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),

        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              type.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),

        Expanded(
          flex: 2,
          child: Text(
            weight,
            textAlign: TextAlign.end,
            style: AppTextStyles.body.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.highlight,
            ),
          ),
        ),
      ],
    ),
  );
}
