import 'provider_status.dart';

class ProviderEntity {
  final String id;
  final String userId;
  final String name;
  final String email;
  final String phoneNumber;
  final String professionalTitle;
  final int yearsOfExperience;
  final String? avatarUrl;
  final String? about;
  final ProviderStatus status;
  final String? rejectionReason;
  final DateTime? submittedAt;
  final DateTime? reviewedAt;
  final double? latitude;
  final double? longitude;
  final double? coverageRadiusKm;
  final List<ProviderServiceEntity> services;
  final List<AvailabilityEntity> availability;
  final List<DocumentEntity> documents;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProviderEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.professionalTitle,
    required this.yearsOfExperience,
    this.avatarUrl,
    this.about,
    required this.status,
    this.rejectionReason,
    this.submittedAt,
    this.reviewedAt,
    this.latitude,
    this.longitude,
    this.coverageRadiusKm,
    this.services = const [],
    this.availability = const [],
    this.documents = const [],
    required this.createdAt,
    required this.updatedAt,
  });
}

class ProviderServiceEntity {
  final String id;
  final String categoryId;
  final String categoryTitle;
  final String categoryIcon;

  const ProviderServiceEntity({
    required this.id,
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryIcon,
  });
}

class AvailabilityEntity {
  final String id;
  final int dayOfWeek;
  final bool isEnabled;
  final String startTime;
  final String endTime;

  const AvailabilityEntity({
    required this.id,
    required this.dayOfWeek,
    required this.isEnabled,
    required this.startTime,
    required this.endTime,
  });
}

class DocumentEntity {
  final String id;
  final String documentType;
  final String fileUrl;
  final String? originalFilename;

  const DocumentEntity({
    required this.id,
    required this.documentType,
    required this.fileUrl,
    this.originalFilename,
  });
}
