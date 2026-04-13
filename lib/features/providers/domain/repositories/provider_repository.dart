import '../entities/provider_entity.dart';
import '../entities/provider_status.dart';

abstract class ProviderRepository {
  Future<List<ProviderEntity>> getProviders({
    ProviderStatus? status,
    String? searchQuery,
    int page = 1,
    int limit = 10,
  });
}
