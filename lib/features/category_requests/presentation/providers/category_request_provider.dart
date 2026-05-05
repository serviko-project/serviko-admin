import '../../../../core/network/pagination_meta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/category_request_entity.dart';
import '../../domain/entities/category_request_status.dart';
import '../../domain/repositories/category_request_repository.dart';
import '../../data/datasources/category_request_datasource.dart';
import '../../data/repositories/category_request_repository_impl.dart';

// Category Request Providers
final categoryRequestDatasourceProvider = Provider<CategoryRequestDatasource>((
  ref,
) {
  return CategoryRequestDatasource();
});

// Repository provider
final categoryRequestRepositoryProvider = Provider<CategoryRequestRepository>((
  ref,
) {
  final datasource = ref.watch(categoryRequestDatasourceProvider);
  return CategoryRequestRepositoryImpl(datasource);
});

// Status filter
class CategoryRequestStatusFilterNotifier
    extends Notifier<CategoryRequestStatus?> {
  @override
  CategoryRequestStatus? build() => null;

  void setFilter(CategoryRequestStatus? status) {
    if (state != status) {
      state = status;
      ref.read(categoryRequestPageProvider.notifier).setPage(1);
      ref.invalidate(categoryRequestCountsProvider);
    }
  }
}

final categoryRequestStatusFilterProvider =
    NotifierProvider<
      CategoryRequestStatusFilterNotifier,
      CategoryRequestStatus?
    >(() {
      return CategoryRequestStatusFilterNotifier();
    });

// Pagination
class CategoryRequestPageNotifier extends Notifier<int> {
  @override
  int build() => 1;

  void setPage(int page) {
    state = page;
  }
}

final categoryRequestPageProvider =
    NotifierProvider<CategoryRequestPageNotifier, int>(() {
      return CategoryRequestPageNotifier();
    });

// List provider — fetches from API with status filter and page
final categoryRequestsListProvider =
    FutureProvider.autoDispose<(List<CategoryRequestEntity>, PaginationMeta)>((
      ref,
    ) async {
      final repository = ref.watch(categoryRequestRepositoryProvider);
      final status = ref.watch(categoryRequestStatusFilterProvider);
      final page = ref.watch(categoryRequestPageProvider);

      return repository.getCategoryRequests(
        status: status,
        page: page,
        limit: 10,
      );
    });

// Recent category requests for dashboard
final recentCategoryRequestsProvider =
    FutureProvider.autoDispose<List<CategoryRequestEntity>>((ref) async {
      final repository = ref.watch(categoryRequestRepositoryProvider);
      final (requests, _) = await repository.getCategoryRequests(
        page: 1,
        limit: 3,
        status: CategoryRequestStatus.pending,
      );
      return requests;
    });

// Counts provider
class CategoryRequestCountsNotifier
    extends AsyncNotifier<Map<CategoryRequestStatus, int>> {
  @override
  Future<Map<CategoryRequestStatus, int>> build() async {
    final repository = ref.watch(categoryRequestRepositoryProvider);
    return repository.getRequestCounts();
  }
}

final categoryRequestCountsProvider =
    AsyncNotifierProvider.autoDispose<
      CategoryRequestCountsNotifier,
      Map<CategoryRequestStatus, int>
    >(() {
      return CategoryRequestCountsNotifier();
    });

// Controller for approve/decline actions
class CategoryRequestController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  // Approve with icon for category creation
  Future<void> approveRequest(
    String requestId,
    String icon, {
    String? title,
    String? status,
  }) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(categoryRequestRepositoryProvider);
      await repository.approveRequest(
        requestId,
        icon,
        title: title,
        status: status,
      );

      // Invalidate list and counts to fresh data
      ref.invalidate(categoryRequestsListProvider);
      ref.invalidate(categoryRequestCountsProvider);
      ref.invalidate(recentCategoryRequestsProvider);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Decline with admin note
  Future<void> declineRequest(String requestId, String adminNote) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(categoryRequestRepositoryProvider);
      await repository.declineRequest(requestId, adminNote);

      // Invalidate list and counts to fresh data
      ref.invalidate(categoryRequestsListProvider);
      ref.invalidate(categoryRequestCountsProvider);
      ref.invalidate(recentCategoryRequestsProvider);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final categoryRequestControllerProvider =
    NotifierProvider<CategoryRequestController, AsyncValue<void>>(() {
      return CategoryRequestController();
    });
