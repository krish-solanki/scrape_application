import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';
import 'package:scrape_application/features/dashboard/screens/dashboard_screen.dart';
import 'package:scrape_application/features/inventory/screen/inventory_screen.dart';
import 'package:scrape_application/features/profile/screen/profile_screen.dart';
import 'package:scrape_application/features/scan/screen/scan_screen.dart';

class AppBottomNav extends StatefulWidget {
  const AppBottomNav({super.key});

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    DashboardScreen(),
    ScanScreen(),
    InventoryScreen(),
    EditProfileScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[selectedIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(
            color: AppColors.border,
          ),
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),

          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: onItemTapped,

            backgroundColor: AppColors.surface,
            elevation: 0,
            type: BottomNavigationBarType.fixed,

            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondary,

            selectedLabelStyle: AppTextStyles.body,
            unselectedLabelStyle: AppTextStyles.body,

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Dashboard',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner),
                label: 'Scan',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2),
                label: 'Inventory',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}