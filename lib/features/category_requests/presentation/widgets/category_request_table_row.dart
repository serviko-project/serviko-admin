import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/entities/category_request_entity.dart';
import '../../domain/entities/category_request_status.dart';
import '../providers/category_request_provider.dart';
import 'category_request_action_button.dart';
import 'category_request_status_badge.dart';
import '../../../../core/utils/date_time_utils.dart';
import 'category_request_details_dialog.dart';

// Builds a TableRow for a Category Request
TableRow buildCategoryRequestTableRow(
  CategoryRequestEntity request,
  WidgetRef ref,
) {
  return TableRow(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.divider, width: 1.0)),
    ),
    children: [
      // Checkbox
      const Padding(
        padding: EdgeInsets.only(
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

      // Provider (Avatar & Name)
      Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
        child: Row(
          children: [
            CircleAvatar(
              radius: AppSizes.md,
              // backgroundImage: NetworkImage(request.providerAvatarUrl),
              backgroundColor: AppColors.border,
              child: Icon(
                Icons.person,
                color: AppColors.textSecondary,
                size: AppSizes.iconMd,
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
      ),

      // Requested Category
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.md,
          horizontal: AppSizes.sm,
        ),
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
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.md,
          horizontal: AppSizes.sm,
        ),
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
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.md,
          horizontal: AppSizes.sm,
        ),
        child: Text(
          DateTimeUtils.formatTimeAgo(request.submittedAt),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),

      // Status
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.md,
          horizontal: AppSizes.sm,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: CategoryRequestStatusBadge(status: request.status),
        ),
      ),

      // Actions
      Padding(
        padding: const EdgeInsets.only(
          right: AppSizes.lg,
          top: AppSizes.md,
          bottom: AppSizes.md,
        ),
        child: Builder(
          builder: (context) => _buildActions(context, request, ref),
        ),
      ),
    ],
  );
}

// Action Buttons of Each Row (Approve, Decline, View Details)
Widget _buildActions(
  BuildContext context,
  CategoryRequestEntity request,
  WidgetRef ref,
) {
  final isPending = request.status == CategoryRequestStatus.pending;
  final isDeclined = request.status == CategoryRequestStatus.declined;

  return Wrap(
    alignment: WrapAlignment.end,
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: AppSizes.sm,
    runSpacing: AppSizes.sm,
    children: [
      if (isPending) ...[
        CategoryRequestActionButton(
          label: 'Approve',
          isFilled: true,
          color: AppColors.success,
          onTap: () => ref
              .read(categoryRequestControllerProvider.notifier)
              .updateStatus(request.id, CategoryRequestStatus.approved),
        ),
        CategoryRequestActionButton(
          label: 'Decline',
          isFilled: false,
          color: AppColors.error,
          onTap: () => ref
              .read(categoryRequestControllerProvider.notifier)
              .updateStatus(request.id, CategoryRequestStatus.declined),
        ),
      ],
      Padding(
        padding: const EdgeInsets.only(left: AppSizes.sm),
        child: IconButton(
          icon: const Icon(
            Icons.remove_red_eye,
            color: AppColors.textHint,
            size: AppSizes.iconMd,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) =>
                  CategoryRequestDetailsDialog(request: request),
            );
          },
        ),
      ),
      // Reconsider Button for Declined Requests
      if (isDeclined)
        InkWell(
          onTap: () => ref
              .read(categoryRequestControllerProvider.notifier)
              .updateStatus(request.id, CategoryRequestStatus.pending),
          child: Padding(
            padding: const EdgeInsets.only(left: AppSizes.sm),
            child: Text(
              'Reconsider',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
    ],
  );
}
