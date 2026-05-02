import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/entities/category_request_entity.dart';
import 'category_request_status_badge.dart';
import '../../../../core/utils/date_time_utils.dart';
import 'category_request_details_dialog.dart';
import '../../../../core/network/api_constants.dart';

// Builds a TableRow for a Category Request
TableRow buildCategoryRequestTableRow(
  CategoryRequestEntity request,
  WidgetRef ref,
  BuildContext context,
) {
  return TableRow(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.divider, width: 1.0)),
    ),
    children: [
      // Checkbox
      Padding(
        padding: const EdgeInsets.only(
          left: AppSizes.lg,
          top: AppSizes.md,
          bottom: AppSizes.md,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.check_box_outline_blank,
            color: AppColors.border,
            size: AppSizes.iconMd,
          ),
        ),
      ),
      ...[
        // Provider (Avatar & Name)
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
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
                          : '${ApiConstants.baseUrl}${request.providerAvatarUrl.startsWith('/') ? '' : '/'}${request.providerAvatarUrl}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(
                              Icons.person,
                              color: AppColors.textSecondary,
                              size: 18,
                            ),
                          ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Icon(
                        Icons.person,
                        color: AppColors.textSecondary,
                        size: 18,
                      ),
                    ),
            ),
            const SizedBox(width: AppSizes.sm),
            Expanded(
              child: Text(
                request.providerName,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),

        // Requested Category
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            request.requestedCategory,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Description
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            request.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Submitted At
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            DateTimeUtils.formatTimeAgo(request.submittedAt),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),

        // Status
        Align(
          alignment: Alignment.centerLeft,
          child: CategoryRequestStatusBadge(status: request.status),
        ),

        // Actions
        Align(
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) =>
                    CategoryRequestDetailsDialog(request: request),
              );
            },
            icon: const Icon(
              Icons.remove_red_eye,
              color: AppColors.primary,
              size: 20,
            ),
            tooltip: 'View Details',
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ),
      ].map(
        (child) => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.md,
            horizontal: AppSizes.md,
          ),
          child: child,
        ),
      ),
    ],
  );
}
