import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/category_entity.dart';
import '../providers/categories_provider.dart';
import 'category_card.dart';

// Display Categories Grid
class CategoriesGrid extends ConsumerStatefulWidget {
  const CategoriesGrid({super.key});

  @override
  ConsumerState<CategoriesGrid> createState() => _CategoriesGridState();
}

class _CategoriesGridState extends ConsumerState<CategoriesGrid> {
  final _gridViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesListProvider);

    return categoriesAsync.when(
      data: (categories) {
        // Show empty state if no categories found
        if (categories.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 80.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    size: 48,
                    color: AppColors.border,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No categories found',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Try adjusting your search or filters.',
                    style: TextStyle(fontSize: 14, color: AppColors.textHint),
                  ),
                ],
              ),
            ),
          );
        }
        // Reorderable Grid View
        return ReorderableBuilder<CategoryEntity>.builder(
          key: Key(_gridViewKey.toString()),
          enableScrollingWhileDragging: false,
          longPressDelay: Duration.zero,
          itemCount: categories.length,
          onReorder: (mapFunction) {
            ref
                .read(categoriesListProvider.notifier)
                .reorder((list) => mapFunction(list));
          },
          childBuilder: (itemBuilder) {
            return GridView.builder(
              key: _gridViewKey,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 290,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                mainAxisExtent: 175,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                // Build each category card
                return itemBuilder(
                  CategoryCard(key: ValueKey(category.id), category: category),
                  index,
                );
              },
            );
          },
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(60.0),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
