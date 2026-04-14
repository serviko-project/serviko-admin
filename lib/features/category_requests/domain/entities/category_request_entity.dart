import 'category_request_status.dart';

class CategoryRequestEntity {
  final String id;
  final String providerName;
  final String providerAvatarUrl;
  final String requestedCategory;
  final String description;
  final DateTime submittedAt;
  final CategoryRequestStatus status;

  CategoryRequestEntity({
    required this.id,
    required this.providerName,
    required this.providerAvatarUrl,
    required this.requestedCategory,
    required this.description,
    required this.submittedAt,
    required this.status,
  });
}
