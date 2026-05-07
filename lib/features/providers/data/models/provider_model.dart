import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/provider_status.dart';

class ProviderModel extends ProviderEntity {
  const ProviderModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.professionalTitle,
    required super.yearsOfExperience,
    super.avatarUrl,
    super.about,
    required super.status,
    super.rejectionReason,
    super.submittedAt,
    super.reviewedAt,
    super.latitude,
    super.longitude,
    super.coverageRadiusKm,
    super.services,
    super.availability,
    super.documents,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['user_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      professionalTitle: json['professional_title'] as String? ?? '',
      yearsOfExperience: (json['years_of_experience'] as num?)?.toInt() ?? 0,
      avatarUrl: json['user_profile_image_url'] as String?,
      about: json['about'] as String?,
      status: ProviderStatus.fromString(json['status'] as String),
      rejectionReason: json['rejection_reason'] as String?,
      submittedAt: json['submitted_at'] != null
          ? DateTime.parse(json['submitted_at'] as String)
          : null,
      reviewedAt: json['reviewed_at'] != null
          ? DateTime.parse(json['reviewed_at'] as String)
          : null,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      coverageRadiusKm: (json['coverage_radius_km'] as num?)?.toDouble(),
      services:
          (json['services'] as List<dynamic>?)
              ?.map(
                (e) => ProviderServiceModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      availability:
          (json['availability'] as List<dynamic>?)
              ?.map(
                (e) => AvailabilityModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      documents:
          (json['documents'] as List<dynamic>?)
              ?.map((e) => DocumentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class ProviderServiceModel extends ProviderServiceEntity {
  const ProviderServiceModel({
    required super.id,
    required super.categoryId,
    required super.categoryTitle,
    required super.categoryIcon,
    required super.basePricePerHour,
  });

  factory ProviderServiceModel.fromJson(Map<String, dynamic> json) {
    return ProviderServiceModel(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      categoryTitle: json['category_title'] as String? ?? '',
      categoryIcon: json['category_icon'] as String? ?? '',
      basePricePerHour: (json['base_price_per_hour'] as num).toDouble(),
    );
  }
}

class AvailabilityModel extends AvailabilityEntity {
  const AvailabilityModel({
    required super.id,
    required super.dayOfWeek,
    required super.isEnabled,
    required super.startTime,
    required super.endTime,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityModel(
      id: json['id'] as String,
      dayOfWeek: json['day_of_week'] as int,
      isEnabled: json['is_enabled'] as bool,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
    );
  }
}

class DocumentModel extends DocumentEntity {
  const DocumentModel({
    required super.id,
    required super.documentType,
    required super.fileUrl,
    super.originalFilename,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'] as String,
      documentType: json['document_type'] as String,
      fileUrl: json['file_url'] as String,
      originalFilename: json['original_filename'] as String?,
    );
  }
}
