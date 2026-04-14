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

// Ctegory Request Status Filter Provider
class CategoryRequestStatusFilterNotifier
    extends Notifier<CategoryRequestStatus?> {
  @override
  CategoryRequestStatus? build() => null;

  void setFilter(CategoryRequestStatus? status) {
    if (state != status) {
      state = status;
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

// Category Request Pagination Provider
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

// Provider that listens to both status and page and fetches accordingly
final categoryRequestsListProvider =
    FutureProvider<List<CategoryRequestEntity>>((ref) async {
      final repository = ref.watch(categoryRequestRepositoryProvider);
      final status = ref.watch(categoryRequestStatusFilterProvider);
      final page = ref.watch(categoryRequestPageProvider);

      return repository.getCategoryRequests(
        status: status,
        page: page,
        limit: 10,
      );
    });

// Category Request Counts Provider
final categoryRequestCountsProvider =
    FutureProvider<Map<CategoryRequestStatus, int>>((ref) async {
      final repository = ref.watch(categoryRequestRepositoryProvider);

      final allItems = await repository.getCategoryRequests(
        page: 1,
        limit: 1000,
      );

      int pending = 0;
      int approved = 0;
      int declined = 0;

      for (var item in allItems) {
        if (item.status == CategoryRequestStatus.pending) {
          pending++;
        } else if (item.status == CategoryRequestStatus.approved) {
          approved++;
        } else if (item.status == CategoryRequestStatus.declined) {
          declined++;
        }
      }

      return {
        CategoryRequestStatus.pending: pending,
        CategoryRequestStatus.approved: approved,
        CategoryRequestStatus.declined: declined,
      };
    });

// For updating request status
class CategoryRequestController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> updateStatus(
    String requestId,
    CategoryRequestStatus newStatus,
  ) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(categoryRequestRepositoryProvider);
      await repository.updateRequestStatus(requestId, newStatus);

      ref.invalidate(categoryRequestsListProvider);
      ref.invalidate(categoryRequestCountsProvider);
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
