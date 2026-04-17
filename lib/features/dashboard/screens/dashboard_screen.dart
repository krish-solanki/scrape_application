import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                // 🔷 HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Dashboard", style: AppTextStyles.heading),
                    CircleAvatar(
                      radius: 18.r,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150?img=3",
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // 🔍 SEARCH BAR
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: AppColors.primary, size: 20.sp),
                      SizedBox(width: 10.w),
                      Text("Search", style: AppTextStyles.body),
                      Spacer(),
                      Icon(Icons.tune, color: AppColors.primary, size: 20.sp),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // 📊 MAIN CARD
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TOTAL SCRAP WEIGHT",
                            style: AppTextStyles.label,
                          ),
                          SizedBox(height: 6.h),
                          Text("14.5 TONS", style: AppTextStyles.heading),
                        ],
                      ),

                      Spacer(),

                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 80.w,
                            height: 80.w,
                            child: CircularProgressIndicator(
                              value: 0.8,
                              strokeWidth: 6.w,
                              backgroundColor: AppColors.border,
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.highlight,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("₹2,80,500", style: AppTextStyles.value),
                              Text(
                                "Potential Value",
                                style: AppTextStyles.label,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25.h),

                // 📌 RECENT SCANS HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recent Scans", style: AppTextStyles.subHeading),
                    Text("ListView", style: AppTextStyles.label),
                  ],
                ),

                SizedBox(height: 15.h),

                // 📋 LIST
                Column(
                  children: [
                    ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return;
                      },
                    ),
                  ],
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
