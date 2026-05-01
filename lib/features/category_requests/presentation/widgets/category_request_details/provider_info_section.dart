import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';
import 'package:serviko_admin/features/category_requests/domain/entities/category_request_entity.dart';

class ProviderInfoSection extends StatelessWidget {
  final CategoryRequestEntity request;

  const ProviderInfoSection({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Text(
            "Requested By",
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: AppSizes.md),
          const CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.border,
            child: Icon(Icons.person, color: AppColors.textSecondary, size: 35),
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

          const SizedBox(height: AppSizes.sm),
          TextButton(
            onPressed: () {},
            child: Text(
              "View Provider Profile",
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
