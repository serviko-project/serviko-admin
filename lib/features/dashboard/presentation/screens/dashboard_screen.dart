import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/features/dashboard/presentation/widgets/category_requests_list.dart';
import 'package:serviko_admin/features/dashboard/presentation/widgets/recent_applications_table.dart';
import 'package:serviko_admin/features/dashboard/presentation/widgets/stat_cards_grid.dart';
import 'package:serviko_admin/features/category_requests/presentation/providers/category_request_provider.dart';
import 'package:serviko_admin/features/providers/presentation/providers/providers_provider.dart';

// Admin Dashboard Screen
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.invalidate(categoryRequestCountsProvider);
      ref.invalidate(recentCategoryRequestsProvider);
      ref.invalidate(pendingProvidersCountProvider);
      ref.invalidate(activeProvidersCountProvider);
      ref.invalidate(recentProvidersProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1200;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stat Cards Grid
              const StatCardsGrid(),

              const SizedBox(height: AppSizes.xl),

              // Content Area
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // Recent Applications Table
                    Expanded(flex: 2, child: RecentApplicationsTable()),
                    SizedBox(width: AppSizes.xl),
                    //  Category Requests List
                    Expanded(flex: 1, child: CategoryRequestsList()),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    RecentApplicationsTable(),
                    SizedBox(height: AppSizes.xl),
                    CategoryRequestsList(),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
