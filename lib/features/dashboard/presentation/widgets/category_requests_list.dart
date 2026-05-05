import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';
import 'package:serviko_admin/core/utils/date_time_utils.dart';
import 'package:serviko_admin/features/category_requests/domain/entities/category_request_status.dart';
import 'package:serviko_admin/features/category_requests/presentation/providers/category_request_provider.dart';
import 'components/request_card.dart';

// Category Requests List Widget
class CategoryRequestsList extends ConsumerWidget {
  const CategoryRequestsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentRequestsAsync = ref.watch(recentCategoryRequestsProvider);
    final requestCountsAsync = ref.watch(categoryRequestCountsProvider);

    final pendingCount = requestCountsAsync.when(
      data: (counts) => counts[CategoryRequestStatus.pending] ?? 0,
      loading: () => 0,
      error: (_, _) => 0,
    );

    return Container(
      padding: const EdgeInsets.all(AppSizes.xl),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category Requests',
                style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$pendingCount PENDING',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.lg),

          // List of Request Cards
          recentRequestsAsync.when(
            data: (requests) {
              if (requests.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.xl),
                    child: Text(
                      'No pending category requests',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final cards = requests.map((request) {
                    final date = request.submittedAt;
                    final formattedDate =
                        '${DateTimeUtils.getMonthName(date.month)} ${date.day}, ${date.year}';

                    return RequestCard(
                      title: request.requestedCategory,
                      requester: request.providerName,
                      date: formattedDate,
                      onView: () => context.go('/category-requests'),
                    );
                  }).toList();

                  // Two-column layout for wider screens
                  if (constraints.maxWidth >= 600) {
                    final cardWidth = ((constraints.maxWidth - AppSizes.md) / 2)
                        .floorToDouble();
                    return Wrap(
                      spacing: AppSizes.md,
                      runSpacing: AppSizes.md,
                      children: cards
                          .map(
                            (card) => SizedBox(width: cardWidth, child: card),
                          )
                          .toList(),
                    );
                  }

                  // Normal single column layout
                  return Column(
                    children: [
                      for (int i = 0; i < cards.length; i++) ...[
                        cards[i],
                        if (i < cards.length - 1)
                          const SizedBox(height: AppSizes.md),
                      ],
                    ],
                  );
                },
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSizes.xl),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, _) => const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSizes.xl),
                child: Text(
                  'Error loading requests',
                  style: TextStyle(color: AppColors.error),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
