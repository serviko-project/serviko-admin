import '../../domain/entities/category_request_entity.dart';
import '../../domain/entities/category_request_status.dart';

class CategoryRequestModel extends CategoryRequestEntity {
  CategoryRequestModel({
    required super.id,
    required super.providerName,
    required super.providerAvatarUrl,
    required super.requestedCategory,
    required super.description,
    required super.submittedAt,
    required super.status,
  });

  factory CategoryRequestModel.fromJson(Map<String, dynamic> json) {
    return CategoryRequestModel(
      id: json['id'],
      providerName: json['providerName'],
      providerAvatarUrl: json['providerAvatarUrl'],
      requestedCategory: json['requestedCategory'],
      description: json['description'],
      submittedAt: DateTime.parse(json['submittedAt']),
      status: CategoryRequestStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => CategoryRequestStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'providerName': providerName,
      'providerAvatarUrl': providerAvatarUrl,
      'requestedCategory': requestedCategory,
      'description': description,
      'submittedAt': submittedAt.toIso8601String(),
      'status': status.name,
    };
  }

  CategoryRequestModel copyWith({
    String? id,
    String? providerName,
    String? providerAvatarUrl,
    String? requestedCategory,
    String? description,
    DateTime? submittedAt,
    CategoryRequestStatus? status,
  }) {
    return CategoryRequestModel(
      id: id ?? this.id,
      providerName: providerName ?? this.providerName,
      providerAvatarUrl: providerAvatarUrl ?? this.providerAvatarUrl,
      requestedCategory: requestedCategory ?? this.requestedCategory,
      description: description ?? this.description,
      submittedAt: submittedAt ?? this.submittedAt,
      status: status ?? this.status,
    );
  }
}
