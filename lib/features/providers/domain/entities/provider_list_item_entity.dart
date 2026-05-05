import 'provider_status.dart';

// Entity for provider list items in the admin dashboard
class ProviderListItemEntity {
  final String id;
  final String userId;
  final String userName;
  final String? email;
  final String? phoneNumber;
  final String? profileImageUrl;
  final String? professionalTitle;
  final ProviderStatus status;
  final List<String> categories;
  final DateTime? submittedAt;
  final DateTime createdAt;

  const ProviderListItemEntity({
    required this.id,
    required this.userId,
    required this.userName,
    this.email,
    this.phoneNumber,
    this.profileImageUrl,
    this.professionalTitle,
    required this.status,
    this.categories = const [],
    this.submittedAt,
    required this.createdAt,
  });
}
