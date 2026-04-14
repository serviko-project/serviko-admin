import '../../domain/entities/category_request_entity.dart';
import '../../domain/entities/category_request_status.dart';
import '../../domain/repositories/category_request_repository.dart';
import '../datasources/category_request_datasource.dart';

class CategoryRequestRepositoryImpl implements CategoryRequestRepository {
  CategoryRequestRepositoryImpl(this._datasource);

  final CategoryRequestDatasource _datasource;

  @override
  Future<List<CategoryRequestEntity>> getCategoryRequests({
    CategoryRequestStatus? status,
    int page = 1,
    int limit = 10,
  }) async {
    return await _datasource.getCategoryRequests(
      status: status,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<CategoryRequestEntity> updateRequestStatus(
    String requestId,
    CategoryRequestStatus newStatus,
  ) async {
    return await _datasource.updateRequestStatus(requestId, newStatus);
  }
}
