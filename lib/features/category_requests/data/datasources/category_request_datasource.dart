import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/pagination_meta.dart';
import '../../domain/entities/category_request_status.dart';
import '../models/category_request_model.dart';

// Remote data source for Category Requests
class CategoryRequestDatasource {
  final Dio _dio = ApiClient().dio;

  // GET /api/v1/category-requests
  Future<(List<CategoryRequestModel>, PaginationMeta)> getCategoryRequests({
    CategoryRequestStatus? status,
    int page = 1,
    int limit = 10,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};
    if (status != null) queryParams['status'] = status.name;

    final response = await _dio.get(
      ApiConstants.categoryRequests,
      queryParameters: queryParams,
    );

    final data = response.data['data'] as List;
    final meta = PaginationMeta.fromJson(response.data['meta']);
    final models = data
        .map((json) => CategoryRequestModel.fromJson(json))
        .toList();

    return (models, meta);
  }

  // GET /api/v1/category-requests/counts
  Future<Map<CategoryRequestStatus, int>> getRequestCounts() async {
    final response = await _dio.get('${ApiConstants.categoryRequests}/counts');

    final data = response.data['data'];
    return {
      CategoryRequestStatus.pending: data['pending'] ?? 0,
      CategoryRequestStatus.approved: data['approved'] ?? 0,
      CategoryRequestStatus.declined: data['declined'] ?? 0,
    };
  }

  // PATCH /api/v1/category-requests/{id}/review
  Future<CategoryRequestModel> approveRequest(
    String id,
    String icon, {
    String? title,
    String? status,
  }) async {
    final response = await _dio.patch(
      '${ApiConstants.categoryRequests}/$id/review',
      data: {
        'action': 'approve',
        'icon': icon,
        'title': title,
        'category_status': status,
      },
    );

    return CategoryRequestModel.fromJson(response.data['data']);
  }

  // PATCH /api/v1/category-requests/{id}/review
  Future<CategoryRequestModel> declineRequest(
    String id,
    String adminNote,
  ) async {
    final response = await _dio.patch(
      '${ApiConstants.categoryRequests}/$id/review',
      data: {'action': 'decline', 'admin_note': adminNote},
    );

    return CategoryRequestModel.fromJson(response.data['data']);
  }
}
