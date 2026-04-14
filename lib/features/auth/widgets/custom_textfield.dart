import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTextField({
  required BuildContext context,
  required String hintText,
  required IconData icon,
  bool isPassword = false,
  TextEditingController? controller,
}) {
  final theme = Theme.of(context);

  return Container(
    margin: EdgeInsets.only(bottom: 12.h),
    decoration: BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: theme.dividerColor,
      ),
    ),
    child: TextField(
      controller: controller,
      obscureText: isPassword,
      style: theme.textTheme.titleMedium,
      cursorColor: theme.colorScheme.primary,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium,
        border: InputBorder.none,

        contentPadding:
            EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),

        prefixIcon: Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 20.sp,
        ),

        suffixIcon: isPassword
            ? Icon(
                Icons.visibility_off,
                color: theme.textTheme.bodyMedium?.color,
                size: 20.sp,
              )
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: theme.dividerColor,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 1.5,
          ),
        ),
      ),
    ),
  );
}