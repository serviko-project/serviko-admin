import '../../../../core/network/pagination_meta.dart';
import '../../domain/entities/category_request_entity.dart';
import '../../domain/entities/category_request_status.dart';
import '../../domain/repositories/category_request_repository.dart';
import '../datasources/category_request_datasource.dart';

class CategoryRequestRepositoryImpl implements CategoryRequestRepository {
  CategoryRequestRepositoryImpl(this._datasource);

  final CategoryRequestDatasource _datasource;

  @override
  Future<(List<CategoryRequestEntity>, PaginationMeta)> getCategoryRequests({
    CategoryRequestStatus? status,
    int page = 1,
    int limit = 10,
  }) async {
    final result = await _datasource.getCategoryRequests(
      status: status,
      page: page,
      limit: limit,
    );
    return (result.$1, result.$2);
  }

  @override
  Future<Map<CategoryRequestStatus, int>> getRequestCounts() async {
    return await _datasource.getRequestCounts();
  }

  @override
  Future<CategoryRequestEntity> approveRequest(
    String requestId,
    String icon, {
    String? title,
    String? status,
  }) async {
    return await _datasource.approveRequest(
      requestId,
      icon,
      title: title,
      status: status,
    );
  }

  @override
  Future<CategoryRequestEntity> declineRequest(
    String requestId,
    String adminNote,
  ) async {
    return await _datasource.declineRequest(requestId, adminNote);
  }
}
