import '../../domain/entities/category_request_entity.dart';
import '../../domain/entities/category_request_status.dart';

class CategoryRequestModel extends CategoryRequestEntity {
  CategoryRequestModel({
    required super.id,
    super.providerProfileId,
    required super.providerName,
    required super.providerAvatarUrl,
    required super.requestedCategory,
    required super.description,
    required super.submittedAt,
    required super.status,
    super.adminNote,
    super.reviewedAt,
  });

  factory CategoryRequestModel.fromJson(Map<String, dynamic> json) {
    return CategoryRequestModel(
      id: json['id'],
      providerProfileId: json['provider_profile_id'],
      providerName: json['provider_name'] ?? '',
      providerAvatarUrl: json['provider_avatar_url'] ?? '',
      requestedCategory: json['requested_category'] ?? '',
      description: json['description'] ?? '',
      submittedAt: DateTime.parse(json['submitted_at']),
      status: CategoryRequestStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => CategoryRequestStatus.pending,
      ),
      adminNote: json['admin_note'],
      reviewedAt: json['reviewed_at'] != null
          ? DateTime.parse(json['reviewed_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider_profile_id': providerProfileId,
      'provider_name': providerName,
      'provider_avatar_url': providerAvatarUrl,
      'requested_category': requestedCategory,
      'description': description,
      'submitted_at': submittedAt.toIso8601String(),
      'status': status.name,
      'admin_note': adminNote,
      'reviewed_at': reviewedAt?.toIso8601String(),
    };
  }

  CategoryRequestModel copyWith({
    String? id,
    String? providerProfileId,
    String? providerName,
    String? providerAvatarUrl,
    String? requestedCategory,
    String? description,
    DateTime? submittedAt,
    CategoryRequestStatus? status,
    String? adminNote,
    DateTime? reviewedAt,
  }) {
    return CategoryRequestModel(
      id: id ?? this.id,
      providerProfileId: providerProfileId ?? this.providerProfileId,
      providerName: providerName ?? this.providerName,
      providerAvatarUrl: providerAvatarUrl ?? this.providerAvatarUrl,
      requestedCategory: requestedCategory ?? this.requestedCategory,
      description: description ?? this.description,
      submittedAt: submittedAt ?? this.submittedAt,
      status: status ?? this.status,
      adminNote: adminNote ?? this.adminNote,
      reviewedAt: reviewedAt ?? this.reviewedAt,
    );
  }
}
