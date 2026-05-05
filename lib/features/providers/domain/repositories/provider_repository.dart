import '../../../../core/network/pagination_meta.dart';
import '../entities/provider_entity.dart';
import '../entities/provider_list_item_entity.dart';
import '../entities/provider_status.dart';

abstract class ProviderRepository {
  Future<(List<ProviderListItemEntity>, PaginationMeta)> getProviders({
    ProviderStatus? status,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  });

  Future<ProviderEntity> getProviderById(String id);

  Future<ProviderEntity> reviewProvider(
    String id, {
    required String action,
    String? rejectionReason,
  });
}
