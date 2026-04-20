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
      phoneNumber: '+91 920723653${index % 10}',
      professionalTitle: 'Professional Title ${index + 1}',
      yearsOfExperience: 3 + (index % 5),
      avatarUrl: '',
      categories: ['Category 1', 'Category 2'],
      submittedAt: DateTime.now().subtract(const Duration(days: 5)),
      rating: index % 2 == 0 ? 4.5 : null,
      jobsCompleted: index % 2 == 0 ? 10 : 0,
      status: index % 3 == 0
          ? ProviderStatus.active
          : index % 3 == 1
          ? ProviderStatus.pending
          : ProviderStatus.blocked,
      documents: [
        DocumentEntity(
          title: 'Government ID.pdf',
          uploadedAt: DateTime.parse('2026-01-10'),
          url: 'doc1.pdf',
        ),
        DocumentEntity(
          title: 'Trade_License_2025.pdf',
          uploadedAt: DateTime.parse('2026-01-10'),
          url: 'doc2.pdf',
        ),
      ],
      availability: const {
        'Monday': '09:00 AM - 06:00 PM',
        'Tuesday': '09:00 AM - 06:00 PM',
        'Wednesday': '09:00 AM - 06:00 PM',
        'Thursday': '09:00 AM - 06:00 PM',
        'Friday': '09:00 AM - 06:00 PM',
        'Saturday': '09:00 AM - 06:00 PM',
        'Sunday': '09:00 AM - 06:00 PM',
      },
      locationName: 'Malappuram, Kerala',
      locationRadius: '8 km operation radius',
      description:
          'I am an experienced professional with over 5 years of expertise in delivering high-quality home maintenance and plumbing solutions. I ensure prompt responses, clean workmanship and complete customer satisfaction in every job I undertake.',
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

  @override
  Future<ProviderEntity> getProviderById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockData.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Provider not found'),
    );
  }

  @override
  Future<void> updateProviderStatus(String id, ProviderStatus newStatus) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _mockData.indexWhere((p) => p.id == id);
    if (index != -1) {
      final old = _mockData[index];
      _mockData[index] = ProviderModel(
        id: old.id,
        name: old.name,
        email: old.email,
        phoneNumber: old.phoneNumber,
        professionalTitle: old.professionalTitle,
        yearsOfExperience: old.yearsOfExperience,
        avatarUrl: old.avatarUrl,
        categories: old.categories,
        submittedAt: old.submittedAt,
        actionTakenAt: DateTime.now(),
        rating: old.rating,
        jobsCompleted: old.jobsCompleted,
        status: newStatus,
        documents: old.documents,
        availability: old.availability,
        locationName: old.locationName,
        locationRadius: old.locationRadius,
      );
    }
  }
}
