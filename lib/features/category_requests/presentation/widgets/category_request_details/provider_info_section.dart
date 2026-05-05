import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';
import 'package:serviko_admin/features/category_requests/domain/entities/category_request_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:serviko_admin/core/network/api_constants.dart';

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
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.border.withValues(alpha: 0.1),
            ),
            clipBehavior: Clip.antiAlias,
            child:
                (request.providerAvatarUrl.isNotEmpty &&
                    request.providerAvatarUrl != 'null')
                ? Image.network(
                    request.providerAvatarUrl.startsWith('http')
                        ? request.providerAvatarUrl
                        : '${ApiConstants.baseUrl}${request.providerAvatarUrl}',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.person,
                        color: AppColors.textSecondary,
                        size: 48,
                      ),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Icon(
                      Icons.person,
                      color: AppColors.textSecondary,
                      size: 48,
                    ),
                  ),
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            request.providerName,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSizes.sm),
          TextButton(
            onPressed: request.providerProfileId != null
                ? () {
                    final router = GoRouter.of(context);
                    Navigator.of(context).pop();
                    router.pushNamed(
                      'provider_details',
                      pathParameters: {'id': request.providerProfileId!},
                    );
                  }
                : null,
            child: Text(
              "View Provider Profile",
              style: AppTextStyles.bodySmall.copyWith(
                color: request.providerProfileId != null
                    ? AppColors.primary
                    : AppColors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
