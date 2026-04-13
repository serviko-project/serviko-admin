import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/provider_status.dart';
import '../../domain/repositories/provider_repository.dart';
import '../../data/repositories/provider_repository_impl.dart';

// --- Repositories ---
final providerRepositoryProvider = Provider<ProviderRepository>((ref) {
  return ProviderRepositoryImpl();
});

// Tab selection
class ProviderStatusFilterNotifier extends Notifier<ProviderStatus?> {
  @override
  ProviderStatus? build() => null;
  void setStatus(ProviderStatus? status) => state = status;
}

final providerStatusFilterProvider =
    NotifierProvider<ProviderStatusFilterNotifier, ProviderStatus?>(() {
      return ProviderStatusFilterNotifier();
    });

// For Search
class ProviderSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';
  void setQuery(String query) => state = query;
}

final providerSearchQueryProvider =
    NotifierProvider<ProviderSearchQueryNotifier, String>(() {
      return ProviderSearchQueryNotifier();
    });

// --- List Providers Details ---
final providersListProvider = FutureProvider<List<ProviderEntity>>((ref) async {
  final repository = ref.watch(providerRepositoryProvider);
  final status = ref.watch(providerStatusFilterProvider);
  final searchQuery = ref.watch(providerSearchQueryProvider);

  return repository.getProviders(status: status, searchQuery: searchQuery);
});

// --- Badge Count Provider ---
final pendingProvidersCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(providerRepositoryProvider);
  final providers = await repository.getProviders(
    status: ProviderStatus.pending,
  );
  return providers.length;
});
