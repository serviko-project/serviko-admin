import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/provider_status.dart';

class ProviderModel extends ProviderEntity {
  const ProviderModel({
    required super.id,
    required super.name,
    required super.email,
    required super.avatarUrl,
    required super.categories,
    required super.submittedAt,
    super.rating,
    required super.jobs,
    required super.status,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String,
      categories: List<String>.from(json['categories'] as List),
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      jobs: json['jobs'] as int,
      status: ProviderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => ProviderStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'categories': categories,
      'submittedAt': submittedAt.toIso8601String(),
      'rating': rating,
      'jobs': jobs,
      'status': status.toString().split('.').last,
    };
  }
}
