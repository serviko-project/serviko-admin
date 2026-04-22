import '../../../../core/utils/icon_mapper.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_status.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.title,
    required super.icon,
    required super.providerCount,
    required super.status,
    super.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: IconMapper.fromName(json['icon'] as String),
      providerCount: json['provider_count'] as int? ?? 0,
      status: CategoryStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => CategoryStatus.active,
      ),
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': IconMapper.toName(icon),
      'status': status.name,
      if (description != null) 'description': description,
    };
  }
}
