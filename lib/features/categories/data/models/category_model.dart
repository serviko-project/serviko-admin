import 'package:flutter/material.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_status.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.title,
    required super.icon,
    required super.providerCount,
    required super.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: IconData(
        int.parse(json['icon'] as String),
        fontFamily: 'MaterialIcons',
      ),
      providerCount: json['providerCount'] as int,
      status: CategoryStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => CategoryStatus.active,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon.codePoint.toString(),
      'providerCount': providerCount,
      'status': status.name,
    };
  }
}
