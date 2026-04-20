import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/provider_entity.dart';
import 'category_chip.dart';
import 'status_badge.dart';

// Builds a Provider TableRow
TableRow buildProviderTableRow(ProviderEntity provider, BuildContext context) {
  void handleTap() {
    context.goNamed('provider_details', pathParameters: {'id': provider.id});
  }

  return TableRow(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.divider, width: 1.0)),
    ),
    children: [
      // Checkbox
      TableRowInkWell(
        onTap: handleTap,
        child: const Padding(
          padding: EdgeInsets.only(left: 24.0, top: 12.0, bottom: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.check_box_outline_blank,
              color: AppColors.border,
              size: 20,
            ),
          ),
        ),
      ),

      // Provider Info (Avatar, Name, Email)
      TableRowInkWell(
        onTap: handleTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                // backgroundImage: NetworkImage(provider.avatarUrl),
                backgroundColor: AppColors.border,
                child: Icon(Icons.person, color: AppColors.textHint, size: 23),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Provider Name
                    Text(
                      provider.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),

                    // Provider Email
                    Text(
                      provider.email,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Categories
      TableRowInkWell(
        onTap: handleTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ...provider.categories
                    .take(3)
                    .map((c) => CategoryChip(label: c)),

                if (provider.categories.length > 3)
                  CategoryChip(
                    label: '+${provider.categories.length - 3} more',
                  ),
              ],
            ),
          ),
        ),
      ),

      // Submitted Date
      TableRowInkWell(
        onTap: handleTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              DateTimeUtils.formatDate(provider.submittedAt),
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ),
      ),

      // Rating
      TableRowInkWell(
        onTap: handleTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: provider.rating != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.warning,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        provider.rating.toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  )
                : const Text(
                    '—',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textHint,
                    ),
                  ),
          ),
        ),
      ),

      // Jobs Count
      TableRowInkWell(
        onTap: handleTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              provider.jobsCompleted.toString(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),

      // Status
      TableRowInkWell(
        onTap: handleTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 24.0, top: 12.0, bottom: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: StatusBadge(status: provider.status),
          ),
        ),
      ),
    ],
  );
}
