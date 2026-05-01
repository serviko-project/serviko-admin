import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/entities/category_request_entity.dart';
import '../../domain/entities/category_request_status.dart';
import 'category_request_details/category_request_action_buttons.dart';
import 'category_request_details/provider_info_section.dart';
import 'category_request_details/request_details_section.dart';

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
                      fontSize: 16,
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
                    RequestDetailsSection(request: request),
                    const SizedBox(height: AppSizes.xl),
                    ProviderInfoSection(request: request),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: RequestDetailsSection(request: request),
                    ),
                    const SizedBox(width: AppSizes.xxl),
                    Expanded(
                      flex: 2,
                      child: ProviderInfoSection(request: request),
                    ),
                  ],
                ),

              if (isPending) ...[
                const SizedBox(height: AppSizes.xxl),
                CategoryRequestActionButtons(request: request),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
