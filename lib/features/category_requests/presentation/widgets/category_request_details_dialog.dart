import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/category_request_entity.dart';
import '../../domain/entities/category_request_status.dart';
import '../providers/category_request_provider.dart';

// Dialog to show category request details and actions
class CategoryRequestDetailsDialog extends ConsumerWidget {
  final CategoryRequestEntity request;

  const CategoryRequestDetailsDialog({super.key, required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPending = request.status == CategoryRequestStatus.pending;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(AppSizes.md),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Review Category Request',
                    style: AppTextStyles.h3.copyWith(
                      fontSize: 18,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSizes.lg),
                child: Divider(color: AppColors.divider, height: 1),
              ),

              // Body Content
              if (isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLeftColumn(),
                    const SizedBox(height: AppSizes.xl),
                    _buildRightColumn(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildLeftColumn()),
                    const SizedBox(width: AppSizes.xxl),
                    Expanded(flex: 2, child: _buildRightColumn()),
                  ],
                ),

              if (isPending) ...[
                const SizedBox(height: AppSizes.xxl),
                _buildActionButtons(context, ref),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Left column with request details
  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REQUESTED CATEGORY',
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          request.requestedCategory,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.xxl),

        Text(
          'DESCRIPTION FROM PROVIDER',
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppSizes.md),
        Container(
          padding: const EdgeInsets.all(AppSizes.lg),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.05),
            border: const Border(
              left: BorderSide(color: AppColors.primary, width: 3),
            ),
          ),
          child: Text(
            request.description,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.xxl),

        Text(
          'SUBMITTED',
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          DateTimeUtils.formatTimeAgo(request.submittedAt),
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }

  // Right column with provider details
  Widget _buildRightColumn() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.border,
            child: Icon(Icons.person, color: AppColors.textSecondary, size: 30),
            // backgroundImage: NetworkImage(request.providerAvatarUrl),
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            request.providerName,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Member since Jan 2025',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textHint,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: AppSizes.xl),

          // Mock Stats
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.warning, size: 14),
              const SizedBox(width: AppSizes.xs),
              Text(
                '4.9 rating',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.textSecondary,
                size: 14,
              ),
              const SizedBox(width: AppSizes.xs),
              Text(
                '23 jobs completed',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.xxl),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'ACTIVE PROVIDER',
              style: AppTextStyles.labelSmall.copyWith(
                color: const Color(0xFF2E7D32),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'View full profile',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right,
                color: AppColors.primary,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Action buttons for approving or declining the request
  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AppSizes.md,
      runSpacing: AppSizes.md,
      children: [
        OutlinedButton(
          onPressed: () {
            ref
                .read(categoryRequestControllerProvider.notifier)
                .updateStatus(request.id, CategoryRequestStatus.declined);
            Navigator.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.error,
            side: const BorderSide(color: AppColors.error),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.xl,
              vertical: AppSizes.md,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            ),
          ),
          child: Text(
            'Decline Request',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.error,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            ref
                .read(categoryRequestControllerProvider.notifier)
                .updateStatus(request.id, CategoryRequestStatus.approved);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.xl,
              vertical: AppSizes.md,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            ),
            elevation: 0,
          ),
          child: Text(
            'Approve & Create Category',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
