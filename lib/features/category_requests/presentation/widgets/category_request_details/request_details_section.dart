import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';
import 'package:serviko_admin/core/utils/date_time_utils.dart';
import 'package:serviko_admin/features/category_requests/domain/entities/category_request_entity.dart';

class RequestDetailsSection extends StatelessWidget {
  final CategoryRequestEntity request;

  const RequestDetailsSection({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Requested Category
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
            fontSize: 14,
          ),
        ),
        const SizedBox(height: AppSizes.xxl),

        // Description Section
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

        // Submission Time
        Row(
          children: [
            Text(
              'SUBMITTED',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              " : ",
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              DateTimeUtils.formatTimeAgo(request.submittedAt),
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
