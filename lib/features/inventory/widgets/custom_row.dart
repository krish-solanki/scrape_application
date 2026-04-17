  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

Widget buildRow(
      String id, String location, String weight, Color statusColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 10.w),

          // ID
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(Icons.check_box,
                    color: statusColor, size: 18.sp),
                SizedBox(width: 6.w),
                Text(id, style: AppTextStyles.subHeading),
              ],
            ),
          ),

          // LOCATION
          Expanded(
            flex: 2,
            child: Text(location, style: AppTextStyles.body),
          ),

          // STATUS
          Expanded(
            child: Text(
              weight,
              style: AppTextStyles.subHeading,
            ),
          ),
        ],
      ),
    );
  }