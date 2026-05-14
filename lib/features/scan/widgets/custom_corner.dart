import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';

Widget buildCorner({required bool top, required bool left}) {
  return Positioned(
    top: top ? 0 : null,
    bottom: top ? null : 0,
    left: left ? 0 : null,
    right: left ? null : 0,

    child: Container(
      width: 34.w,
      height: 34.w,

      decoration: BoxDecoration(
        border: Border(
          top: top
              ? BorderSide(color: AppColors.primary, width: 4.w)
              : BorderSide.none,

          bottom: !top
              ? BorderSide(color: AppColors.primary, width: 4.w)
              : BorderSide.none,

          left: left
              ? BorderSide(color: AppColors.primary, width: 4.w)
              : BorderSide.none,

          right: !left
              ? BorderSide(color: AppColors.primary, width: 4.w)
              : BorderSide.none,
        ),
      ),
    ),
  );
}
