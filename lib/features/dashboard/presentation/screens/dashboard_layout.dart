import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/features/dashboard/presentation/widgets/sidebar_menu.dart';
import 'package:serviko_admin/features/dashboard/presentation/widgets/top_header.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsiveness
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    // Determine the title based on route
    final currentLocation = GoRouterState.of(context).uri.path;
    String pageTitle = 'Dashboard';
    if (currentLocation.startsWith('/providers')) {
      pageTitle = 'Providers';
    } else if (currentLocation.startsWith('/categories')) {
      pageTitle = 'Categories';
    } else if (currentLocation.startsWith('/category-requests')) {
      pageTitle = 'Category Requests';
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Row(
        children: [
          // Show sidebar only on desktop
          if (isDesktop) const SidebarMenu(),

          // Main content area
          Expanded(
            child: Column(
              children: [
                // Top Header
                TopHeader(isDesktop: isDesktop, title: pageTitle),

                // Body Content
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
      // Drawer for mobile navigation
      drawer: isDesktop ? null : const Drawer(child: SidebarMenu()),
    );
  }
}
