import 'package:flutter/material.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_status.dart';
import '../../domain/repositories/category_repository.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final List<CategoryEntity> _mockCategories = [
    const CategoryModel(
      id: '1',
      title: 'House Cleaning',
      icon: Icons.cleaning_services_outlined,
      providerCount: 10,
      status: CategoryStatus.active,
    ),
    const CategoryModel(
      id: '2',
      title: 'Plumbing',
      icon: Icons.plumbing_outlined,
      providerCount: 20,
      status: CategoryStatus.active,
    ),
    const CategoryModel(
      id: '3',
      title: 'Painting',
      icon: Icons.format_paint_outlined,
      providerCount: 30,
      status: CategoryStatus.active,
    ),
    const CategoryModel(
      id: '4',
      title: 'Laundry',
      icon: Icons.local_laundry_service_outlined,
      providerCount: 40,
      status: CategoryStatus.active,
    ),
    const CategoryModel(
      id: '5',
      title: 'Appliance Repair',
      icon: Icons.build_outlined,
      providerCount: 50,
      status: CategoryStatus.active,
    ),
    const CategoryModel(
      id: '6',
      title: 'Car Repair',
      icon: Icons.directions_car_outlined,
      providerCount: 60,
      status: CategoryStatus.inactive,
    ),
    const CategoryModel(
      id: '7',
      title: 'Gardening',
      icon: Icons.park_outlined,
      providerCount: 42,
      status: CategoryStatus.inactive,
    ),
  ];

  @override
  Future<List<CategoryEntity>> getCategories({
    CategoryStatus? status,
    String? searchQuery,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return _mockCategories.where((category) {
      final matchesStatus = status == null || category.status == status;

      bool matchesSearch = true;
      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final query = searchQuery.toLowerCase().trim();
        final title = category.title.toLowerCase();

        matchesSearch = title.contains(query);
      }

      return matchesStatus && matchesSearch;
    }).toList();
  }
}
