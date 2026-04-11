import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';
import 'components/menu_tile.dart';

// Sidebar Menu Widget
class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Current path
    final currentLocation = GoRouterState.of(context).uri.path;

    return Container(
      width: 250,
      color: AppColors.sidebarBackground,
      child: Column(
        children: [
          // Logo Area
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.xl,
              horizontal: AppSizes.lg,
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/app_logo.webp",
                  width: 35,
                  height: 35,
                ),
                const SizedBox(width: AppSizes.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SERVIKO',
                      style: AppTextStyles.h3.copyWith(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ADMIN CONSOLE',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white54,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.md),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              children: [
                // Dashboard Menu Item
                MenuTile(
                  icon: Icons.dashboard_outlined,
                  title: 'Dashboard',
                  isActive: currentLocation.startsWith('/dashboard'),
                  onTap: () => context.go('/dashboard'),
                ),

                // Providers Menu Item
                MenuTile(
                  icon: Icons.people_outline,
                  title: 'Providers',
                  isActive: currentLocation.startsWith('/providers'),
                  onTap: () {},
                ),

                // Categories Menu Item
                MenuTile(
                  icon: Icons.category_outlined,
                  title: 'Categories',
                  isActive: currentLocation.startsWith('/categories'),
                  onTap: () {},
                ),

                // Category Requests Menu Item
                MenuTile(
                  icon: Icons.assignment_outlined,
                  title: 'Category Requests',
                  isActive: currentLocation.startsWith('/category-requests'),
                  onTap: () {},
                  badgeCount: 3,
                ),
              ],
            ),
          ),

          // Admin Profile Area
          Container(
            padding: const EdgeInsets.all(AppSizes.md),
            margin: const EdgeInsets.all(AppSizes.md),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(10),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withAlpha(10),
                  child: const Icon(Icons.person, color: AppColors.primary),
                ),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Serviko Admin',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'admin@serviko.com',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.settings, color: Colors.white54, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
