import 'package:flutter/material.dart';
import 'category_status.dart';

class CategoryEntity {
  final String id;
  final String title;
  final IconData icon;
  final int providerCount;
  final CategoryStatus status;
  final String? description;

  const CategoryEntity({
    required this.id,
    required this.title,
    required this.icon,
    required this.providerCount,
    required this.status,
    this.description,
  });
}
