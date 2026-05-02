import '../../../../core/network/pagination_meta.dart';
import '../entities/category_request_entity.dart';
import '../entities/category_request_status.dart';

abstract class CategoryRequestRepository {
  Future<(List<CategoryRequestEntity>, PaginationMeta)> getCategoryRequests({
    CategoryRequestStatus? status,
    int page = 1,
    int limit = 10,
  });

  Future<Map<CategoryRequestStatus, int>> getRequestCounts();

  Future<CategoryRequestEntity> approveRequest(
    String requestId,
    String icon, {
    String? title,
    String? status,
  });

  Future<CategoryRequestEntity> declineRequest(
    String requestId,
    String adminNote,
  );
}
