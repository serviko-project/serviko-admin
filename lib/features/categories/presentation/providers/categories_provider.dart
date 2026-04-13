import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_status.dart';
import '../../domain/repositories/category_repository.dart';

// Category Repository Provider
final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl();
});

// Status Filter state
class CategoryStatusFilterNotifier extends Notifier<CategoryStatus?> {
  @override
  CategoryStatus? build() => null;

  void setFilter(CategoryStatus? status) => state = status;
}

final categoryStatusFilterProvider =
    NotifierProvider<CategoryStatusFilterNotifier, CategoryStatus?>(
      CategoryStatusFilterNotifier.new,
    );

// Search Query state
class CategorySearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setSearchQuery(String query) => state = query;
}

final categorySearchQueryProvider =
    NotifierProvider<CategorySearchQueryNotifier, String>(
      CategorySearchQueryNotifier.new,
    );

// Categories List Provider
class CategoriesListNotifier extends AsyncNotifier<List<CategoryEntity>> {
  @override
  FutureOr<List<CategoryEntity>> build() async {
    final repository = ref.watch(categoryRepositoryProvider);
    final status = ref.watch(categoryStatusFilterProvider);
    final searchQuery = ref.watch(categorySearchQueryProvider);

    return repository.getCategories(status: status, searchQuery: searchQuery);
  }

  // Method to reorder categories
  void reorder(
    List<CategoryEntity> Function(List<CategoryEntity>) mapFunction,
  ) {
    if (state.value == null) return;

    final currentList = List<CategoryEntity>.from(state.value!);
    final updatedList = mapFunction(currentList);

    state = AsyncData(updatedList);
  }
}

// Provider to get categories
final categoriesListProvider =
    AsyncNotifierProvider.autoDispose<
      CategoriesListNotifier,
      List<CategoryEntity>
    >(() => CategoriesListNotifier());

// Stats Provider for total, active and inactive categories
final categoriesStatsProvider = FutureProvider.autoDispose<Map<String, int>>((
  ref,
) async {
  final repository = ref.watch(categoryRepositoryProvider);

  final allCategories = await repository.getCategories();

  int active = 0;
  int inactive = 0;

  for (var cat in allCategories) {
    if (cat.status == CategoryStatus.active) {
      active++;
    } else {
      inactive++;
    }
  }

  return {
    'total': allCategories.length,
    'active': active,
    'inactive': inactive,
  };
});
