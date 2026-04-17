import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';
import 'package:scrape_application/features/inventory/widgets/custom_nav_tab.dart';
import 'package:scrape_application/features/inventory/widgets/custom_row.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),

              // 🔷 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Inventory", style: AppTextStyles.heading),
                  Icon(Icons.menu, color: AppColors.textPrimary),
                ],
              ),

              SizedBox(height: 20.h),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
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

              SizedBox(height: 15.h),

              Row(
                children: [
                  buildNavTab("Weight Type"),
                  SizedBox(width: 8.w),
                  buildNavTab("Location"),
                  SizedBox(width: 8.w),
                  buildNavTab("Critical Weight"),
                ],
              ),

              SizedBox(height: 16.h),

              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.highlight.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.highlight,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        "Surat Warehouse is full! Time to sell to recycler",
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.highlight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10.w),
                    Expanded(
                      flex: 2,
                      child: Text("ITEM ID", style: AppTextStyles.label),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("LOCATION", style: AppTextStyles.label),
                    ),
                    Expanded(child: Text("STATUS", style: AppTextStyles.label)),
                  ],
                ),
              ),

              SizedBox(height: 10.h),

              Expanded(
                child: ListView(
                  children: [
                    buildRow("001012", "Rajkot", "380 kg", AppColors.warning),
                    buildRow("000796", "Surat", "115 kg", AppColors.success),
                    buildRow(
                      "001004",
                      "Bengaluru",
                      "260 kg",
                      AppColors.success,
                    ),
                    buildRow("000450", "Rajkot", "210 kg", AppColors.warning),

                    SizedBox(height: 10.h),

                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Showing 10 of 104", style: AppTextStyles.body),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14.sp,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
