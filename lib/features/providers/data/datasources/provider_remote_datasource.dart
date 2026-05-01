import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/pagination_meta.dart';
import '../../domain/entities/provider_status.dart';
import '../models/provider_list_item_model.dart';
import '../models/provider_model.dart';

// Remote Data Source for Providers
class ProviderRemoteDatasource {
  final Dio _dio = ApiClient().dio;

  // GET /api/v1/providers
  Future<(List<ProviderListItemModel>, PaginationMeta)> getProviders({
    ProviderStatus? status,
    String? search,
    int page = 1,
    int limit = 20,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};

    if (status != null) queryParams['status'] = status.name;
    if (search != null && search.trim().isNotEmpty) {
      queryParams['search'] = search.trim();
    }

    final response = await _dio.get(
      ApiConstants.providers,
      queryParameters: queryParams,
    );

    final data = response.data['data'] as List;
    final meta = PaginationMeta.fromJson(
      response.data['meta'] as Map<String, dynamic>,
    );

    final items = data
        .map(
          (json) =>
              ProviderListItemModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();

    return (items, meta);
  }

  // GET /api/v1/providers/{id}
  Future<ProviderModel> getProviderById(String id) async {
    final response = await _dio.get('${ApiConstants.providers}/$id');
    return ProviderModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }

  // PATCH /api/v1/providers/{id}/review
  Future<ProviderModel> reviewProvider(
    String id, {
    required String action,
    String? rejectionReason,
  }) async {
    final body = <String, dynamic>{'action': action};
    if (rejectionReason != null) {
      body['rejection_reason'] = rejectionReason;
    }

    final response = await _dio.patch(
      '${ApiConstants.providers}/$id/review',
      data: body,
    );

    return ProviderModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }
}
