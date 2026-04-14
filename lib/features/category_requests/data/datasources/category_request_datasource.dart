import '../../domain/entities/category_request_status.dart';
import '../models/category_request_model.dart';

class CategoryRequestDatasource {
  static final List<CategoryRequestModel> _requests = [
    for (int i = 1; i <= 20; i++)
      CategoryRequestModel(
        id: i.toString(),
        providerName: 'Provider $i',
        providerAvatarUrl: '',
        requestedCategory: 'Service Category $i',
        description: 'Description of Service $i Requested.',
        submittedAt: DateTime.now().subtract(Duration(days: i)),
        status: i % 3 == 0
            ? CategoryRequestStatus.pending
            : i % 3 == 1
            ? CategoryRequestStatus.approved
            : CategoryRequestStatus.declined,
      ),
  ];

  // Get Category Requests
  Future<List<CategoryRequestModel>> getCategoryRequests({
    CategoryRequestStatus? status,
    int page = 1,
    int limit = 10,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    List<CategoryRequestModel> filtered = List.from(_requests);

    if (status != null) {
      filtered = filtered.where((r) => r.status == status).toList();
    }

    // Sort by submitted at, newest first
    filtered.sort((a, b) => b.submittedAt.compareTo(a.submittedAt));

    final startIndex = (page - 1) * limit;
    if (startIndex >= filtered.length) return [];

    final endIndex = startIndex + limit;
    final end = endIndex > filtered.length ? filtered.length : endIndex;

    return filtered.sublist(startIndex, end);
  }

  // Update Request Status
  Future<CategoryRequestModel> updateRequestStatus(
    String id,
    CategoryRequestStatus newStatus,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _requests.indexWhere((r) => r.id == id);
    if (index == -1) throw Exception('Request not found');

    final updated = _requests[index].copyWith(status: newStatus);
    _requests[index] = updated;
    return updated;
  }
}
