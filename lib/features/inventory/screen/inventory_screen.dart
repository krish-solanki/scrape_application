import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';

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

              // 🔽 FILTER BUTTONS
              Row(
                children: [
                  _filterChip("Weight Type"),
                  SizedBox(width: 8.w),
                  _filterChip("Location"),
                  SizedBox(width: 8.w),
                  _filterChip("Critical Weight"),
                ],
              ),

              SizedBox(height: 16.h),

              // ⚠️ ALERT CARD
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.highlight.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: AppColors.highlight),
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

              // 📊 TABLE HEADER
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
                    Expanded(
                      child: Text("STATUS", style: AppTextStyles.label),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h),

              // 📋 TABLE LIST
              Expanded(
                child: ListView(
                  children: [
                    _buildRow("001012", "Rajkot", "380 kg",
                        AppColors.warning),
                    _buildRow("000796", "Surat", "115 kg",
                        AppColors.success),
                    _buildRow("001004", "Bengaluru", "260 kg",
                        AppColors.success),
                    _buildRow("000450", "Rajkot", "210 kg",
                        AppColors.warning),

                    SizedBox(height: 10.h),

                    // 🔽 FOOTER ROW
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Showing 10 of 104",
                              style: AppTextStyles.body),
                          Icon(Icons.arrow_forward_ios,
                              size: 14.sp,
                              color: AppColors.textSecondary),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔷 FILTER CHIP
  Widget _filterChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Text(text, style: AppTextStyles.body),
          SizedBox(width: 4.w),
          Icon(Icons.keyboard_arrow_down,
              size: 16.sp, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  // 🔷 TABLE ROW
  Widget _buildRow(
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
}