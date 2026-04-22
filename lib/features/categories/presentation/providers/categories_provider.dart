import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/category_remote_datasource.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_status.dart';
import '../../domain/repositories/category_repository.dart';

// Remote datasource provider
final _categoryDatasourceProvider = Provider<CategoryRemoteDatasource>((ref) {
  return CategoryRemoteDatasource();
});

// Category Repository Provider
final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl(ref.watch(_categoryDatasourceProvider));
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

// Debounced search query state
class CategorySearchQueryNotifier extends Notifier<String> {
  Timer? _debounce;

  @override
  String build() => '';

  void setSearchQuery(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      state = query;
    });
  }

  // Clear search query 
  void clearSearch() {
    _debounce?.cancel();
    state = '';
  }
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

  // Create category
  Future<bool> createCategory({
    required String title,
    required String iconName,
    String? description,
    CategoryStatus status = CategoryStatus.active,
  }) async {
    try {
      final repository = ref.read(categoryRepositoryProvider);
      await repository.createCategory(
        title: title,
        iconName: iconName,
        description: description,
        status: status,
      );
      ref.invalidateSelf();
      ref.invalidate(categoriesStatsProvider);
      return true;
    } catch (_) {
      return false;
    }
  }

  // Update category
  Future<bool> updateCategory({
    required String id,
    String? title,
    String? iconName,
    String? description,
    CategoryStatus? status,
  }) async {
    try {
      final repository = ref.read(categoryRepositoryProvider);
      await repository.updateCategory(
        id: id,
        title: title,
        iconName: iconName,
        description: description,
        status: status,
      );
      ref.invalidateSelf();
      ref.invalidate(categoriesStatsProvider);
      return true;
    } catch (_) {
      return false;
    }
  }

  // Delete category
  Future<bool> deleteCategory(String id) async {
    try {
      final repository = ref.read(categoryRepositoryProvider);
      await repository.deleteCategory(id);
      ref.invalidateSelf();
      ref.invalidate(categoriesStatsProvider);
      return true;
    } catch (_) {
      return false;
    }
  }

  // Toggle status between active/inactive
  Future<bool> toggleStatus(CategoryEntity category) async {
    final newStatus = category.status == CategoryStatus.active
        ? CategoryStatus.inactive
        : CategoryStatus.active;

    return updateCategory(id: category.id, status: newStatus);
  }

  // Reorder categories locally
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
