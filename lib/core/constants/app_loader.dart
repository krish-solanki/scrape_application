import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background.withOpacity(0.95),

      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            RotationTransition(
              turns: controller,

              child: Container(
                width: 90.w,
                height: 90.w,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: AppColors.card,

                  border: Border.all(color: AppColors.primary, width: 4.w),

                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.35),
                      blurRadius: 25,
                      spreadRadius: 2,
                    ),
                  ],
                ),

                child: Center(
                  child: Icon(
                    Icons.precision_manufacturing,
                    color: AppColors.highlight,
                    size: 32.sp,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              "Processing...",
              style: AppTextStyles.subHeading.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
