import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';
import 'package:scrape_application/features/inventory/controllers/inventory_controller.dart';
import 'package:scrape_application/features/inventory/widgets/custom_dropdown_list.dart';
import 'package:scrape_application/features/inventory/widgets/custom_row.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String selectedType = 'All';
  String selectedSource = 'All';
  String selectedWeight = 'All';
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<InventoryController>().getLocalScans(context: context);
    });
  }

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
              Text("Inventory", style: AppTextStyles.heading),

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
                  Consumer<InventoryController>(
                    builder: (context, provider, child) {
                      return buildDropdownTab(
                        value: provider.selectedType,
                        items: const [
                          'All',
                          'Iron',
                          'Steel',
                          'Copper',
                          'Aluminum',
                        ],
                        onChanged: (value) {
                          provider.changeType(value!);
                        },
                      );
                    },
                  ),

                  SizedBox(width: 8.w),

                  Consumer<InventoryController>(
                    builder: (context, provider, child) {
                      return buildDropdownTab(
                        value: provider.selectedSource,
                        items: const ['Local', 'Online'],
                        onChanged: (value) {
                          provider.changeSource(value!, context);
                        },
                      );
                    },
                  ),

                  SizedBox(width: 8.w),

                  Consumer<InventoryController>(
                    builder: (context, provider, child) {
                      return buildDropdownTab(
                        value: provider.selectedWeight,
                        items: const [
                          'All',
                          '0-10 Kg',
                          '10-50 Kg',
                          '50-100 Kg',
                          '100+ Kg',
                        ],
                        onChanged: (value) {
                          provider.changeWeight(value!);
                        },
                      );
                    },
                  ),
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
                      flex: 3,
                      child: Text("Label", style: AppTextStyles.label),
                    ),

                    Expanded(
                      flex: 2,
                      child: Text("TYPE", style: AppTextStyles.label),
                    ),

                    Expanded(
                      flex: 2,
                      child: Text("WEIGHT", style: AppTextStyles.label),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h),

              Expanded(
                child: Consumer<InventoryController>(
                  builder: (context, provider, child) {
                    if (provider.displayScans.isEmpty) {
                      return const Center(child: Text('No Data Found'));
                    }
                    return ListView.builder(
                      itemCount: provider.displayScans.length,
                      itemBuilder: (context, index) {
                        final scan = provider.displayScans[index];

                        return buildRow(
                          scan.name,
                          scan.scrapType,
                          "${scan.weight} ${scan.unit}",
                          AppColors.success,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
