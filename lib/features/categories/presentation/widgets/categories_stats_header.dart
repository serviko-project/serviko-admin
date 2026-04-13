import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/categories_provider.dart';

// Categories Stats Header showing Total, Active, Inactive counts
class CategoriesStatsHeader extends ConsumerWidget {
  const CategoriesStatsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(categoriesStatsProvider);

    final stats = statsAsync.value ?? {'total': 0, 'active': 0, 'inactive': 0};

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        if (isMobile) {
          return Column(
            children: [
              //  Total Categories Card
              _buildStatCard(
                title: 'TOTAL CATEGORIES',
                value: stats['total']?.toString().padLeft(2, '0') ?? '00',
                icon: Icons.category,
                iconBgColor: AppColors.primary.withAlpha(20),
                iconColor: AppColors.primary,
              ),
              const SizedBox(height: 12),

              // Active Status Card
              _buildStatCard(
                title: 'ACTIVE STATUS',
                value: stats['active']?.toString().padLeft(2, '0') ?? '00',
                icon: Icons.check_circle,
                iconBgColor: AppColors.success.withAlpha(30),
                iconColor: AppColors.success,
              ),
              const SizedBox(height: 12),

              // Inactive Status Card
              _buildStatCard(
                title: 'INACTIVE STATUS',
                value: stats['inactive']?.toString().padLeft(2, '0') ?? '00',
                icon: Icons.visibility_off,
                iconBgColor: AppColors.warning.withAlpha(30),
                iconColor: AppColors.warning,
              ),
            ],
          );
        }

        // Desktop Layout
        return Row(
          children: [
            // Total Categories Card
            Expanded(
              child: _buildStatCard(
                title: 'TOTAL CATEGORIES',
                value: stats['total']?.toString().padLeft(2, '0') ?? '00',
                icon: Icons.category,
                iconBgColor: AppColors.primary.withAlpha(20),
                iconColor: AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            // Active Status Card
            Expanded(
              child: _buildStatCard(
                title: 'ACTIVE STATUS',
                value: stats['active']?.toString().padLeft(2, '0') ?? '00',
                icon: Icons.check_circle,
                iconBgColor: AppColors.success.withAlpha(30),
                iconColor: AppColors.success,
              ),
            ),
            const SizedBox(width: 16),
            // Inactive Status Card
            Expanded(
              child: _buildStatCard(
                title: 'INACTIVE STATUS',
                value: stats['inactive']?.toString().padLeft(2, '0') ?? '00',
                icon: Icons.visibility_off,
                iconBgColor: AppColors.warning.withAlpha(30),
                iconColor: AppColors.warning,
              ),
            ),
          ],
        );
      },
    );
  }

  // Helper method to build each stat card
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withAlpha(30), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(20),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),

                // Value
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
