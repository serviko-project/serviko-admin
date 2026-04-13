import 'provider_status.dart';

class ProviderEntity {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final List<String> categories;
  final DateTime submittedAt;
  final double? rating;
  final int jobs;
  final ProviderStatus status;

  const ProviderEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.categories,
    required this.submittedAt,
    this.rating,
    required this.jobs,
    required this.status,
  });
}
