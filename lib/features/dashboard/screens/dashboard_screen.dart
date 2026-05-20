import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_strings.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';
import 'package:scrape_application/features/dashboard/controllers/dashboard_controller.dart';
import 'package:scrape_application/features/dashboard/widgets/custom_listview.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final strings = AppStrings();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<DashboardController>().getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Consumer<DashboardController>(
          builder: (context, controller, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 10.h),

                  // 🔷 HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        strings.dashboard,
                        style: AppTextStyles.heading.copyWith(fontSize: 26.sp),
                      ),

                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundImage:
                              controller.user != null &&
                                  controller.user!.image.isNotEmpty
                              ? MemoryImage(
                                  base64Decode(controller.user!.image),
                                )
                              : const NetworkImage(
                                  "https://i.pravatar.cc/150?img=3",
                                ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // 🔍 SEARCH BAR
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 14.h,
                    ),

                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14.r),

                      border: Border.all(color: AppColors.border),
                    ),

                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: AppColors.primary,
                          size: 22.sp,
                        ),

                        SizedBox(width: 10.w),

                        Text(
                          "Search",
                          style: AppTextStyles.body.copyWith(fontSize: 14.sp),
                        ),

                        const Spacer(),

                        Icon(
                          Icons.tune,
                          color: AppColors.highlight,
                          size: 22.sp,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 22.h),

                  // 📊 MAIN CARD
                  Container(
                    padding: EdgeInsets.all(18.w),

                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(20.r),

                      border: Border.all(color: AppColors.border),
                    ),

                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                "TOTAL SCRAP WEIGHT",
                                style: AppTextStyles.label,
                              ),

                              SizedBox(height: 8.h),

                              Text(
                                "14.5 TONS",
                                style: AppTextStyles.heading.copyWith(
                                  fontSize: 24.sp,
                                ),
                              ),

                              SizedBox(height: 8.h),

                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 6.h,
                                ),

                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),

                                child: Text(
                                  "+12% this month",
                                  style: AppTextStyles.label.copyWith(
                                    color: AppColors.success,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Stack(
                          alignment: Alignment.center,

                          children: [
                            SizedBox(
                              width: 90.w,
                              height: 90.w,

                              child: CircularProgressIndicator(
                                value: 0.8,
                                strokeWidth: 7.w,
                                backgroundColor: AppColors.border,
                                valueColor: AlwaysStoppedAnimation(
                                  AppColors.highlight,
                                ),
                              ),
                            ),

                            Column(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text(
                                  "₹2,80,500",
                                  style: AppTextStyles.value.copyWith(
                                    fontSize: 15.sp,
                                  ),
                                ),

                                SizedBox(height: 2.h),

                                Text(
                                  "Potential Value",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.label.copyWith(
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // 📌 RECENT SCANS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        "Recent Scans",
                        style: AppTextStyles.subHeading.copyWith(
                          fontSize: 18.sp,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),

                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(30.r),
                        ),

                        child: Text(
                          "View All",
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 12,

                      itemBuilder: (context, index) {
                        return buildListview();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
