import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/features/categories/presentation/providers/categories_provider.dart';
import 'package:serviko_admin/features/category_requests/domain/entities/category_request_status.dart';
import 'package:serviko_admin/features/category_requests/presentation/providers/category_request_provider.dart';
import 'package:serviko_admin/features/providers/presentation/providers/providers_provider.dart';
import 'components/stat_card.dart';

// Grid of Stat Cards on the Dashboard
class StatCardsGrid extends ConsumerWidget {
  const StatCardsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 4;
        if (constraints.maxWidth < 600) {
          crossAxisCount = 1;
        } else if (constraints.maxWidth < 1100) {
          crossAxisCount = 2;
        }

        final activeProvidersCount = ref.watch(activeProvidersCountProvider);
        final pendingProvidersCount = ref.watch(pendingProvidersCountProvider);
        final categoriesStats = ref.watch(categoriesStatsProvider);
        final categoryRequestCounts = ref.watch(categoryRequestCountsProvider);

        return GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSizes.lg,
            mainAxisSpacing: AppSizes.lg,
            mainAxisExtent: 130,
          ),
          children: [
            // Active Providers Card
            StatCard(
              title: 'ACTIVE PROVIDERS',
              value: activeProvidersCount.when(
                data: (count) => count.toString(),
                loading: () => '...',
                error: (_, _) => '0',
              ),
              badgeText: 'Approved',
              badgeColor: Colors.green,
              icon: Icons.people,
              iconColor: Colors.blue,
            ),

            // Pending Approvals Card
            StatCard(
              title: 'PENDING APPROVALS',
              value: pendingProvidersCount.when(
                data: (count) => count.toString(),
                loading: () => '...',
                error: (_, _) => '0',
              ),
              badgeText: 'Needs review',
              badgeColor: Colors.orange,
              icon: Icons.verified_user,
              iconColor: Colors.orange,
            ),

            // Total Categories Card
            StatCard(
              title: 'TOTAL CATEGORIES',
              value: categoriesStats.when(
                data: (stats) => (stats['total'] ?? 0).toString(),
                loading: () => '...',
                error: (_, _) => '0',
              ),
              badgeText: 'Active & Inactive',
              badgeColor: Colors.green,
              icon: Icons.category,
              iconColor: Colors.purple,
            ),

            // Category Requests Card
            StatCard(
              title: 'CATEGORY REQUESTS',
              value: categoryRequestCounts.when(
                data: (counts) =>
                    (counts[CategoryRequestStatus.pending] ?? 0).toString(),
                loading: () => '...',
                error: (_, _) => '0',
              ),
              badgeText: 'Awaiting action',
              badgeColor: Colors.purple,
              icon: Icons.assignment,
              iconColor: Colors.purple,
            ),
          ],
        );
      },
    );
  }
}
