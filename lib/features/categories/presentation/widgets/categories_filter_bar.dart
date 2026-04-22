import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entities/category_status.dart';
import '../providers/categories_provider.dart';
import 'add_or_edit_category_dialog.dart';

// Categories Filter Bar with Search and Status Tabs
class CategoriesFilterBar extends ConsumerStatefulWidget {
  const CategoriesFilterBar({super.key});

  @override
  ConsumerState<CategoriesFilterBar> createState() =>
      _CategoriesFilterBarState();
}

class _CategoriesFilterBarState extends ConsumerState<CategoriesFilterBar> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Reset search query
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categorySearchQueryProvider.notifier).setSearchQuery('');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedFilter = ref.watch(categoryStatusFilterProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 5,
            children: [
              // Search Field
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _searchController,
                    builder: (context, value, child) {
                      return CustomTextField(
                        controller: _searchController,
                        hintText: 'Search categories...',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.textHint,
                          size: 18,
                        ),
                        suffixIcon: value.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: AppColors.textHint,
                                  size: 18,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  final notifier =
                                      categorySearchQueryProvider.notifier;
                                  ref.read(notifier).clearSearch();
                                },
                              )
                            : null,
                        onChanged: (val) => ref
                            .read(categorySearchQueryProvider.notifier)
                            .setSearchQuery(val),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Filters Tab & Button Row
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // All Tab
                  _buildTab(context, ref, 'All', null, selectedFilter),
                  const SizedBox(width: 6),

                  // Active Tab
                  _buildTab(
                    context,
                    ref,
                    'Active',
                    CategoryStatus.active,
                    selectedFilter,
                  ),
                  const SizedBox(width: 6),

                  // Inactive Tab
                  _buildTab(
                    context,
                    ref,
                    'Inactive',
                    CategoryStatus.inactive,
                    selectedFilter,
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const AddorEditCategoryDialog(),
                        );
                      },
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text(
                        'Add Category',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textOnPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  // Build Filter Tab Widget
  Widget _buildTab(
    BuildContext context,
    WidgetRef ref,
    String label,
    CategoryStatus? status,
    CategoryStatus? currentStatus,
  ) {
    final isSelected = currentStatus == status;

    return GestureDetector(
      onTap: () =>
          ref.read(categoryStatusFilterProvider.notifier).setFilter(status),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? null : Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? AppColors.textOnPrimary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
