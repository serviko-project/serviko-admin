import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/pagination_meta.dart';
import '../../data/datasources/provider_remote_datasource.dart';
import '../../data/repositories/provider_repository_impl.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/provider_list_item_entity.dart';
import '../../domain/entities/provider_status.dart';
import '../../domain/repositories/provider_repository.dart';

// --- Repository & Datasource ---
final _providerDatasourceProvider = Provider<ProviderRemoteDatasource>((ref) {
  return ProviderRemoteDatasource();
});

final providerRepositoryProvider = Provider<ProviderRepository>((ref) {
  return ProviderRepositoryImpl(ref.watch(_providerDatasourceProvider));
});

// --- Tab Filter ---
class ProviderStatusFilterNotifier extends Notifier<ProviderStatus?> {
  @override
  ProviderStatus? build() => null;

  void setStatus(ProviderStatus? status) {
    state = status;
    // Reset page when filter changes
    ref.read(providerPageProvider.notifier).reset();
  }
}

final providerStatusFilterProvider =
    NotifierProvider<ProviderStatusFilterNotifier, ProviderStatus?>(() {
      return ProviderStatusFilterNotifier();
    });

// --- Search ---
class ProviderSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
    // Reset page when search changes
    ref.read(providerPageProvider.notifier).reset();
  }
}

final providerSearchQueryProvider =
    NotifierProvider<ProviderSearchQueryNotifier, String>(() {
      return ProviderSearchQueryNotifier();
    });

// --- Pagination ---
class ProviderPageNotifier extends Notifier<int> {
  @override
  int build() => 1;

  void setPage(int page) => state = page;
  void nextPage() => state++;
  void previousPage() {
    if (state > 1) state--;
  }

  void reset() => state = 1;
}

final providerPageProvider = NotifierProvider<ProviderPageNotifier, int>(() {
  return ProviderPageNotifier();
});

final providerPageLimitProvider = Provider<int>((ref) => 20);

// --- List Result ---
final providersListProvider =
    FutureProvider.autoDispose<(List<ProviderListItemEntity>, PaginationMeta)>((
      ref,
    ) async {
      final repository = ref.watch(providerRepositoryProvider);
      final status = ref.watch(providerStatusFilterProvider);
      final searchQuery = ref.watch(providerSearchQueryProvider);
      final page = ref.watch(providerPageProvider);
      final limit = ref.watch(providerPageLimitProvider);

      return repository.getProviders(
        status: status,
        searchQuery: searchQuery,
        page: page,
        limit: limit,
      );
    });

// --- Pending Badge Count ---
final pendingProvidersCountProvider = FutureProvider.autoDispose<int>((
  ref,
) async {
  final repository = ref.watch(providerRepositoryProvider);
  final (_, meta) = await repository.getProviders(
    status: ProviderStatus.pending,
    page: 1,
    limit: 1,
  );
  return meta.total;
});

// --- Active Providers Count ---
final activeProvidersCountProvider = FutureProvider.autoDispose<int>((
  ref,
) async {
  final repository = ref.watch(providerRepositoryProvider);
  final (_, meta) = await repository.getProviders(
    status: ProviderStatus.approved,
    page: 1,
    limit: 1,
  );
  return meta.total;
});

// --- Recent Providers for Dashboard ---
final recentProvidersProvider =
    FutureProvider.autoDispose<List<ProviderListItemEntity>>((ref) async {
      final repository = ref.watch(providerRepositoryProvider);
      final (providers, _) = await repository.getProviders(page: 1, limit: 4);
      return providers;
    });

// --- Provider Details ---
final providerDetailsProvider = FutureProvider.autoDispose
    .family<ProviderEntity, String>((ref, id) async {
      final repository = ref.watch(providerRepositoryProvider);
      return repository.getProviderById(id);
    });

// --- Review Action Notifier ---
class ProviderReviewActionNotifier extends AsyncNotifier<String?> {
  ProviderReviewActionNotifier(this.providerId);
  final String providerId;

  String? activeAction;

  @override
  Future<String?> build() async => null;

  Future<void> reviewProvider({
    required String action,
    String? rejectionReason,
  }) async {
    activeAction = action;
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repo = ref.read(providerRepositoryProvider);
      await repo.reviewProvider(
        providerId,
        action: action,
        rejectionReason: rejectionReason,
      );

      //
      ref.invalidate(pendingProvidersCountProvider);
      ref.invalidate(providersListProvider);
      ref.invalidate(providerDetailsProvider(providerId));

      //
      await Future.wait([
        ref.read(pendingProvidersCountProvider.future),
        ref.read(providerDetailsProvider(providerId).future),
      ]);

      return action;
    });

    activeAction = null;
  }
}

final providerReviewActionProvider =
    AsyncNotifierProvider.family<ProviderReviewActionNotifier, String?, String>(
      ProviderReviewActionNotifier.new,
    );
