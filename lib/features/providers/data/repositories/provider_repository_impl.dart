import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/provider_status.dart';
import '../../domain/repositories/provider_repository.dart';
import '../models/provider_model.dart';

class ProviderRepositoryImpl implements ProviderRepository {
  // Mock data
  final List<ProviderModel> _mockData = List.generate(
    10,
    (index) => ProviderModel(
      id: "provider_${index + 1}",
      name: 'Provider ${index + 1}',
      email: 'provider${index + 1}@serviko.com',
      avatarUrl: '',
      categories: ['CLEANING', 'PLUMBING'],
      submittedAt: DateTime(2026, 4, 12),
      rating: 4.5,
      jobs: 123,
      status: index % 2 == 0 ? ProviderStatus.active : ProviderStatus.pending,
    ),
  );

  @override
  Future<List<ProviderEntity>> getProviders({
    ProviderStatus? status,
    String? searchQuery,
    int page = 1,
    int limit = 10,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    var results = _mockData.toList();

    // Apply status filter
    if (status != null) {
      results = results.where((p) => p.status == status).toList();
    }

    // Apply search filter
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final lowerQuery = searchQuery.toLowerCase();
      results = results
          .where(
            (p) =>
                p.name.toLowerCase().contains(lowerQuery) ||
                p.email.toLowerCase().contains(lowerQuery) ||
                p.categories.any((c) => c.toLowerCase().contains(lowerQuery)),
          )
          .toList();
    }
    return results;
  }
}
