import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_status.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_datasource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._datasource);

  final CategoryRemoteDatasource _datasource;

  @override
  Future<List<CategoryEntity>> getCategories({
    CategoryStatus? status,
    String? searchQuery,
  }) async {
    return _datasource.getCategories(status: status, search: searchQuery);
  }

  @override
  Future<CategoryEntity> createCategory({
    required String title,
    required String iconName,
    String? description,
    CategoryStatus status = CategoryStatus.active,
  }) async {
    final body = <String, dynamic>{
      'title': title,
      'icon': iconName,
      'status': status.name,
    };
    if (description != null) body['description'] = description;

    return _datasource.createCategory(body);
  }

  @override
  Future<CategoryEntity> updateCategory({
    required String id,
    String? title,
    String? iconName,
    String? description,
    CategoryStatus? status,
  }) async {
    final body = <String, dynamic>{};
    if (title != null) body['title'] = title;
    if (iconName != null) body['icon'] = iconName;
    if (description != null) body['description'] = description;
    if (status != null) body['status'] = status.name;

    return _datasource.updateCategory(id, body);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _datasource.deleteCategory(id);
  }
}
