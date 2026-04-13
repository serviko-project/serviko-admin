import '../entities/category_entity.dart';
import '../entities/category_status.dart';

abstract class CategoryRepository {
  // Fetch categories with optional filtering by status and search query
  Future<List<CategoryEntity>> getCategories({
    CategoryStatus? status,
    String? searchQuery,
  });
}
