import '../entities/category_entity.dart';
import '../entities/category_status.dart';

abstract class CategoryRepository {
  // Fetch categories with optional filtering
  Future<List<CategoryEntity>> getCategories({
    CategoryStatus? status,
    String? searchQuery,
  });

  // Create a new category
  Future<CategoryEntity> createCategory({
    required String title,
    required String iconName,
    String? description,
    CategoryStatus status = CategoryStatus.active,
  });

  // Update an existing category
  Future<CategoryEntity> updateCategory({
    required String id,
    String? title,
    String? iconName,
    String? description,
    CategoryStatus? status,
  });

  // Soft delete a category
  Future<void> deleteCategory(String id);
}
