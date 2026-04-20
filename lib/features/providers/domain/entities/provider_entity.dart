import 'provider_status.dart';

class ProviderEntity {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String professionalTitle;
  final int yearsOfExperience;
  final String avatarUrl;
  final List<String> categories;
  final DateTime submittedAt;
  final DateTime? actionTakenAt;
  final double? rating;
  final int jobsCompleted;
  final ProviderStatus status;
  final List<DocumentEntity> documents;
  final Map<String, String> availability;
  final String locationName;
  final String locationRadius;
  final String description;

  const ProviderEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.professionalTitle,
    required this.yearsOfExperience,
    required this.avatarUrl,
    required this.categories,
    required this.submittedAt,
    this.actionTakenAt,
    this.rating,
    required this.jobsCompleted,
    required this.status,
    required this.documents,
    required this.availability,
    required this.locationName,
    required this.locationRadius,
    this.description = '',
  });
}

class DocumentEntity {
  final String title;
  final DateTime uploadedAt;
  final String url;

  const DocumentEntity({
    required this.title,
    required this.uploadedAt,
    required this.url,
  });
}
