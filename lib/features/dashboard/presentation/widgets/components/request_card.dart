import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';

// Request Card Widget for displaying individual service requests
class RequestCard extends StatelessWidget {
  final String title;
  final String requester;
  final String date;
  final VoidCallback? onView;

  const RequestCard({
    super.key,
    required this.title,
    required this.requester,
    required this.date,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Request Title
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

          // Requester
          Text(
            'Requested by: $requester',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),

          // Date
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 12,
                color: AppColors.textHint,
              ),
              const SizedBox(width: 4),
              Text(
                date,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),

          // Action Button: View
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onView,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 8),
                textStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.3,
                ),
              ),
              child: const Text(
                'VIEW REQUESTS',
                style: TextStyle(letterSpacing: .8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
