import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_constants.dart';
import '../../domain/entities/category_status.dart';
import '../models/category_model.dart';

// Remote data source for Category
class CategoryRemoteDatasource {
  final Dio _dio = ApiClient().dio;

  // GET /api/v1/categories
  Future<List<CategoryModel>> getCategories({
    CategoryStatus? status,
    String? search,
    int page = 1,
    int limit = 100,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};

    if (status != null) queryParams['status'] = status.name;
    if (search != null && search.trim().isNotEmpty) {
      queryParams['search'] = search.trim();
    }

    final response = await _dio.get(
      ApiConstants.categories,
      queryParameters: queryParams,
    );

    final data = response.data['data'] as List;
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }

  // POST /api/v1/categories
  Future<CategoryModel> createCategory(Map<String, dynamic> body) async {
    final response = await _dio.post(ApiConstants.categories, data: body);

    return CategoryModel.fromJson(response.data['data']);
  }

  // PATCH /api/v1/categories/{id}
  Future<CategoryModel> updateCategory(
    String id,
    Map<String, dynamic> body,
  ) async {
    final response = await _dio.patch(
      '${ApiConstants.categories}/$id',
      data: body,
    );

    return CategoryModel.fromJson(response.data['data']);
  }

  // DELETE /api/v1/categories/{id}
  Future<void> deleteCategory(String id) async {
    await _dio.delete('${ApiConstants.categories}/$id');
  }
}
