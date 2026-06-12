import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_strings.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';
import 'package:scrape_application/features/dashboard/controller/dashboard_controller.dart';
import 'package:scrape_application/features/dashboard/widgets/custom_listview.dart';
import 'package:scrape_application/features/inventory/widgets/custom_dropdown_list.dart';

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

    Future.microtask(() async {
      final controller = context.read<DashboardController>();
      await controller.getUserData();
      if (controller.selectedScan == 'Local') {
        await controller.getLocalScans(context: context);
      } else {
        await controller.getOnlineScans(context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Consumer<DashboardController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(strings.dashboard, style: AppTextStyles.heading),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.all(2.w),

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          border: Border.all(
                            color: AppColors.primary,
                            width: 0.5,
                          ),
                        ),

                        child: CircleAvatar(
                          radius: 17.r,
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

                  SizedBox(height: 22.h),

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
                                "${controller.totalWeight.toStringAsFixed(1)} KG",
                                style: AppTextStyles.label,
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
                                  "₹${controller.totalValue.toStringAsFixed(0)}",
                                  style: AppTextStyles.label,
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        "Recent Scans",

                        style: AppTextStyles.subHeading.copyWith(
                          fontSize: 18.sp,
                        ),
                      ),

                      Consumer<DashboardController>(
                        builder: (context, provider, child) {
                          return buildDropdownTab(
                            value: provider.selectedScan,
                            items: const ['Local', 'Online'],
                            onChanged: (value) async {
                              if (value == provider.selectedScan) {
                                return;
                              }

                              provider.changeMode(value!);

                              if (value == 'Local') {
                                await provider.getLocalScans(context: context);
                              } else {
                                await provider.getOnlineScans(context: context);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  Expanded(
                    child: Consumer<DashboardController>(
                      builder: (context, provider, child) {
                        if (provider.recentScans.isEmpty) {
                          return const Center(child: Text("No Recent Scans"));
                        }

                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: provider.recentScans.length,
                          itemBuilder: (context, index) {
                            final scan = provider.recentScans[index];

                            return buildListview(
                              name: scan.name,
                              scrapType: scan.scrapType,
                              weight: "${scan.weight} ${scan.unit}",
                              price: "₹${scan.totalPrice.toStringAsFixed(0)}",
                              image: scan.imageUrl,
                            );
                          },
                        );
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
