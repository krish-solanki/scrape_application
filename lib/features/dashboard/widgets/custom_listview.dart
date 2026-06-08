import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

Widget buildListview({
  required String name,
  required String scrapType,
  required String weight,
  required String price,
  required String image,
}) {
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
          child: image.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.memory(base64Decode(image), fit: BoxFit.cover),
                )
              : Icon(Icons.inventory_2, color: AppColors.primary),
        ),

        SizedBox(width: 12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.subHeading,
              ),

              SizedBox(height: 4.h),

              Text(scrapType, style: AppTextStyles.body),

              SizedBox(height: 2.h),

              Text(weight, style: AppTextStyles.label),
            ],
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              price,
              style: AppTextStyles.subHeading.copyWith(
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: 6.h),

            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ],
    ),
  );
}
