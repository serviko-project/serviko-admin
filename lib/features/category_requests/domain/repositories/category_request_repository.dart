import '../entities/category_request_entity.dart';
import '../entities/category_request_status.dart';

abstract class CategoryRequestRepository {
  Future<List<CategoryRequestEntity>> getCategoryRequests({
    CategoryRequestStatus? status,
    int page = 1,
    int limit = 10,
  });

  Future<CategoryRequestEntity> updateRequestStatus(
    String requestId,
    CategoryRequestStatus newStatus,
  );
}
