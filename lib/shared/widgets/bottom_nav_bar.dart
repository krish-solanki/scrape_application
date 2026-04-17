import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/features/auth/screens/login_screen.dart';
import 'package:scrape_application/features/auth/screens/register_screen.dart';
import 'package:scrape_application/features/dashboard/screens/dashboard_screen.dart';
import 'package:scrape_application/features/inventory/screen/inventory_screen.dart';
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
    RegisterScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      body: screens[selectedIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(color: theme.dividerColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            backgroundColor: theme.colorScheme.surface,
            elevation: 0,
            type: BottomNavigationBarType.fixed,

            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: theme.textTheme.bodyMedium?.color,

            selectedLabelStyle: theme.textTheme.bodyMedium,
            unselectedLabelStyle: theme.textTheme.bodyMedium,

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
