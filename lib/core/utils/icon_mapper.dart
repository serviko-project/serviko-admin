import 'package:flutter/material.dart';

// Maps Icon Name to IconData and vice versa
abstract final class IconMapper {
  static const Map<String, IconData> _nameToIcon = {
    'flash_on_rounded': Icons.flash_on_rounded,
    'home_rounded': Icons.home_rounded,
    'build_rounded': Icons.build_rounded,
    'water_drop_rounded': Icons.water_drop_rounded,
    'ac_unit_rounded': Icons.ac_unit_rounded,
    'local_shipping_rounded': Icons.local_shipping_rounded,
    'security_rounded': Icons.security_rounded,
    'palette_rounded': Icons.palette_rounded,
    'cleaning_services_rounded': Icons.cleaning_services_rounded,
    'yard_rounded': Icons.yard_rounded,
    'computer_rounded': Icons.computer_rounded,
    'directions_car_rounded': Icons.directions_car_rounded,
    'format_paint_rounded': Icons.format_paint_rounded,
    'iron_rounded': Icons.iron_rounded,
    'pets_rounded': Icons.pets_rounded,
    'engineering_rounded': Icons.engineering_rounded,
    'camera_alt_rounded': Icons.camera_alt_rounded,
    'spa_rounded': Icons.spa_rounded,
    'fitness_center_rounded': Icons.fitness_center_rounded,
    'fastfood_rounded': Icons.fastfood_rounded,
    'shopping_bag_rounded': Icons.shopping_bag_rounded,
    'medical_services_rounded': Icons.medical_services_rounded,
    'chair_rounded': Icons.chair_rounded,
    'inventory_2_rounded': Icons.inventory_2_rounded,
    'cleaning_services_outlined': Icons.cleaning_services_outlined,
    'plumbing_outlined': Icons.plumbing_outlined,
    'format_paint_outlined': Icons.format_paint_outlined,
    'local_laundry_service_outlined': Icons.local_laundry_service_outlined,
    'build_outlined': Icons.build_outlined,
    'directions_car_outlined': Icons.directions_car_outlined,
    'park_outlined': Icons.park_outlined,
  };

  // Get all available icons
  static List<IconData> get availableIcons => _nameToIcon.values.toList();

  // Create reverse mapping for IconData to name
  static final Map<int, String> _codePointToName = {
    for (final entry in _nameToIcon.entries) entry.value.codePoint: entry.key,
  };

  // Convert icon name string to IconData
  static IconData fromName(String name) {
    return _nameToIcon[name] ?? Icons.category_rounded;
  }

  // Convert IconData to its corresponding name string
  static String toName(IconData icon) {
    return _codePointToName[icon.codePoint] ?? 'category_rounded';
  }
}
