import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/provider_entity.dart';
import 'category_chip.dart';
import 'status_badge.dart';

// Builds a Provider TableRow
TableRow buildProviderTableRow(ProviderEntity provider) {
  return TableRow(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.divider, width: 1.0)),
    ),
    children: [
      // Checkbox
      const Padding(
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

      // Provider Info (Avatar, Name, Email)
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            CircleAvatar(
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

      // Categories
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: provider.categories
                .map((category) => CategoryChip(label: category))
                .toList(),
          ),
        ),
      ),

      // Submitted Date
      Padding(
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

      // Rating
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: provider.rating != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: AppColors.warning, size: 16),
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

      // Jobs Count
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            provider.jobs.toString(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),

      // Status
      Padding(
        padding: const EdgeInsets.only(right: 24.0, top: 12.0, bottom: 12.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: StatusBadge(status: provider.status),
        ),
      ),
    ],
  );
}
