import '../../domain/entities/provider_list_item_entity.dart';
import '../../domain/entities/provider_status.dart';

class ProviderListItemModel extends ProviderListItemEntity {
  const ProviderListItemModel({
    required super.id,
    required super.userId,
    required super.userName,
    super.email,
    super.phoneNumber,
    super.profileImageUrl,
    super.professionalTitle,
    required super.status,
    super.categories,
    super.submittedAt,
    required super.createdAt,
  });

  factory ProviderListItemModel.fromJson(Map<String, dynamic> json) {
    return ProviderListItemModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String? ?? '',
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      profileImageUrl: json['user_profile_image_url'] as String?,
      professionalTitle: json['professional_title'] as String?,
      status: ProviderStatus.fromString(json['status'] as String),
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      submittedAt: json['submitted_at'] != null
          ? DateTime.parse(json['submitted_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
