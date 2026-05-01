import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';
import 'package:serviko_admin/features/category_requests/domain/entities/category_request_entity.dart';
import 'package:serviko_admin/features/category_requests/domain/entities/category_request_status.dart';
import 'package:serviko_admin/features/category_requests/presentation/providers/category_request_provider.dart';

class CategoryRequestActionButtons extends ConsumerWidget {
  final CategoryRequestEntity request;

  const CategoryRequestActionButtons({super.key, required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(categoryRequestControllerProvider.notifier);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AppSizes.md,
      runSpacing: AppSizes.md,
      children: [
        // Decline Button
        OutlinedButton(
          onPressed: () {
            notifier.updateStatus(request.id, CategoryRequestStatus.declined);
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

        // Approve Button
        ElevatedButton(
          onPressed: () {
            notifier.updateStatus(request.id, CategoryRequestStatus.approved);
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
