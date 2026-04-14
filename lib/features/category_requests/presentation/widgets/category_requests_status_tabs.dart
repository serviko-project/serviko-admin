import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/entities/category_request_status.dart';
import '../providers/category_request_provider.dart';

// Status Filter Tabs for Category Requests
class CategoryRequestsStatusTabs extends ConsumerWidget {
  const CategoryRequestsStatusTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countsAsync = ref.watch(categoryRequestCountsProvider);
    final currentStatus = ref.watch(categoryRequestStatusFilterProvider);

    return countsAsync.when(
      data: (counts) {
        final total = counts.values.fold<int>(0, (sum, val) => sum + val);
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // All Tab with total count
              _buildTab(
                context,
                ref,
                status: null,
                currentStatus: currentStatus,
                label: '$total All',
                color: AppColors.textPrimary,
                backgroundColor: AppColors.textPrimary.withValues(alpha: 0.1),
                icon: Icons.all_inclusive,
              ),
              const SizedBox(width: AppSizes.md),

              // Pending Tab
              _buildTab(
                context,
                ref,
                status: CategoryRequestStatus.pending,
                currentStatus: currentStatus,
                label: '${counts[CategoryRequestStatus.pending]} Pending',
                color: AppColors.warning,
                backgroundColor: AppColors.warning.withValues(alpha: 0.1),
                icon: Icons.schedule,
              ),
              const SizedBox(width: AppSizes.md),

              // Approved Tab
              _buildTab(
                context,
                ref,
                status: CategoryRequestStatus.approved,
                currentStatus: currentStatus,
                label: '${counts[CategoryRequestStatus.approved]} Approved',
                color: AppColors.primary,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                icon: Icons.check_circle,
              ),
              const SizedBox(width: AppSizes.md),

              // Declined Tab
              _buildTab(
                context,
                ref,
                status: CategoryRequestStatus.declined,
                currentStatus: currentStatus,
                label: '${counts[CategoryRequestStatus.declined]} Declined',
                color: AppColors.error,
                backgroundColor: AppColors.error.withValues(alpha: 0.1),
                icon: Icons.cancel,
              ),
            ],
          ),
        );
      },
      // Loading State
      loading: () => Row(
        children: List.generate(
          4,
          (index) => Padding(
            padding: const EdgeInsets.only(right: AppSizes.md),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 100,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.border.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppSizes.radiusXl),
              ),
            ),
          ),
        ),
      ),
      // Error State
      error: (error, _) => Text('Error loading status counts: $error'),
    );
  }

  // Builds each individual status tab
  Widget _buildTab(
    BuildContext context,
    WidgetRef ref, {
    required CategoryRequestStatus? status,
    required CategoryRequestStatus? currentStatus,
    required String label,
    required Color color,
    required Color backgroundColor,
    required IconData icon,
  }) {
    final isActive = currentStatus == status;

    return InkWell(
      onTap: () {
        ref
            .read(categoryRequestStatusFilterProvider.notifier)
            .setFilter(status);
      },
      borderRadius: BorderRadius.circular(AppSizes.radiusXl),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.sm,
        ),
        decoration: BoxDecoration(
          color: isActive ? color : backgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.radiusXl),
          border: Border.all(
            color: isActive ? color : color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppSizes.iconSm,
              color: isActive ? Colors.white : color,
            ),
            const SizedBox(width: AppSizes.sm),
            Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: isActive ? Colors.white : color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
