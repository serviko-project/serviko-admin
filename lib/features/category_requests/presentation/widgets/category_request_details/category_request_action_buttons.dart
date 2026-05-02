import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';
import 'package:serviko_admin/features/category_requests/domain/entities/category_request_entity.dart';
import 'package:serviko_admin/features/categories/presentation/widgets/add_or_edit_category_dialog.dart';
import 'package:serviko_admin/features/category_requests/presentation/widgets/decline_category_request_dialog.dart';

class CategoryRequestActionButtons extends ConsumerWidget {
  final CategoryRequestEntity request;

  const CategoryRequestActionButtons({super.key, required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AppSizes.md,
      runSpacing: AppSizes.md,
      children: [
        // Decline Button
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();

            showDialog(
              context: context,
              useRootNavigator: true,
              builder: (_) => DeclineCategoryRequestDialog(request: request),
            );
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

        // Approve Button
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();

            showDialog(
              context: context,
              useRootNavigator: true,
              builder: (_) => AddorEditCategoryDialog(categoryRequest: request),
            );
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
