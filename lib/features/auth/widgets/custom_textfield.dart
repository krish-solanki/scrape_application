import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

Widget buildTextField({
  required BuildContext context,
  required String hintText,
  required IconData icon,
  bool isPassword = false,
  TextEditingController? controller,
  bool isEmail = false,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 12.h),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14.r),
      border: Border.all(color: AppColors.border),
    ),
    child: TextFormField(
      controller: controller,
      readOnly: isEmail,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: AppTextStyles.subHeading.copyWith(fontSize: 14.sp),
      cursorColor: AppColors.primary,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: AppTextStyles.body,

        border: InputBorder.none,

        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),

        prefixIcon: Icon(icon, color: AppColors.primary, size: 20.sp),

        suffixIcon: isPassword
            ? Icon(
                Icons.visibility_off,
                color: AppColors.textSecondary,
                size: 20.sp,
              )
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.border),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    ),
  );
}
