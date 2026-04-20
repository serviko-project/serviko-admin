import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/provider_status.dart';

class ProviderModel extends ProviderEntity {
  const ProviderModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.professionalTitle,
    required super.yearsOfExperience,
    required super.avatarUrl,
    required super.categories,
    required super.submittedAt,
    super.actionTakenAt,
    super.rating,
    required super.jobsCompleted,
    required super.status,
    required super.documents,
    required super.availability,
    required super.locationName,
    required super.locationRadius,
    super.description,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      professionalTitle: json['professionalTitle'] as String? ?? '',
      yearsOfExperience: (json['yearsOfExperience'] as num?)?.toInt() ?? 0,
      avatarUrl: json['avatarUrl'] as String,
      categories: List<String>.from(json['categories'] as List),
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      jobsCompleted: json['jobsCompleted'] as int,
      status: ProviderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => ProviderStatus.pending,
      ),
      documents: (json['documents'] as List)
          .map((e) => DocumentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      availability: Map<String, String>.from(json['availability'] as Map),
      locationName: json['locationName'] as String,
      locationRadius: json['locationRadius'] as String,
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'professionalTitle': professionalTitle,
      'yearsOfExperience': yearsOfExperience,
      'avatarUrl': avatarUrl,
      'categories': categories,
      'submittedAt': submittedAt.toIso8601String(),
      'actionTakenAt': actionTakenAt?.toIso8601String(),
      'rating': rating,
      'jobsCompleted': jobsCompleted,
      'status': status.toString().split('.').last,
      'documents': documents.map((e) => (e as DocumentModel).toJson()).toList(),
      'availability': availability,
      'locationName': locationName,
      'locationRadius': locationRadius,
      'description': description,
    };
  }
}

class DocumentModel extends DocumentEntity {
  const DocumentModel({
    required super.title,
    required super.uploadedAt,
    required super.url,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      title: json['title'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'uploadedAt': uploadedAt.toIso8601String(),
      'url': url,
    };
  }
}
