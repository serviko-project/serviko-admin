import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../providers/category_request_provider.dart';
import '../widgets/category_requests_list_container.dart';
import '../widgets/category_requests_status_tabs.dart';

// Category Requests Screen
class CategoryRequestsScreen extends ConsumerWidget {
  const CategoryRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(categoryRequestsListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Chips
            const CategoryRequestsStatusTabs(),

            const SizedBox(height: AppSizes.lg),

            // Category Requests Table
            requestsAsync.when(
              data: (requests) =>
                  CategoryRequestsListContainer(requests: requests, ref: ref),

              // Loading State
              loading: () => CategoryRequestsListContainer(
                requests: const [],
                isLoading: true,
                ref: ref,
              ),

              // Error State
              error: (error, stackTrace) => Center(
                child: Text(
                  'Error: $error',
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
