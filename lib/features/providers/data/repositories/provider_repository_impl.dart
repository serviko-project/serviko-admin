import '../../../../core/network/pagination_meta.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/provider_list_item_entity.dart';
import '../../domain/entities/provider_status.dart';
import '../../domain/repositories/provider_repository.dart';
import '../datasources/provider_remote_datasource.dart';

class ProviderRepositoryImpl implements ProviderRepository {
  final ProviderRemoteDatasource _datasource;

  ProviderRepositoryImpl(this._datasource);

  @override
  Future<(List<ProviderListItemEntity>, PaginationMeta)> getProviders({
    ProviderStatus? status,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    return _datasource.getProviders(
      status: status,
      search: searchQuery,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<ProviderEntity> getProviderById(String id) async {
    return _datasource.getProviderById(id);
  }

  @override
  Future<ProviderEntity> reviewProvider(
    String id, {
    required String action,
    String? rejectionReason,
  }) async {
    return _datasource.reviewProvider(
      id,
      action: action,
      rejectionReason: rejectionReason,
    );
  }
}
