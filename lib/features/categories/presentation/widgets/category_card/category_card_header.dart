import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/features/categories/domain/entities/category_entity.dart';
import 'package:serviko_admin/features/categories/domain/entities/category_status.dart';

class CategoryCardHeader extends StatelessWidget {
  final CategoryEntity category;
  final Function(bool) onToggleStatus;

  const CategoryCardHeader({
    super.key,
    required this.category,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = category.status == CategoryStatus.active;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(category.icon, color: AppColors.primary, size: 20),
          ),
        ),
        Row(
          children: [
            Text(
              isActive ? 'ACTIVE' : 'INACTIVE',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: isActive ? AppColors.textSecondary : AppColors.textHint,
              ),
            ),
            const SizedBox(width: 3),
            Transform.scale(
              scale: 0.65,
              child: Switch(
                value: isActive,
                onChanged: onToggleStatus,
                activeTrackColor: AppColors.success,
                inactiveThumbColor: AppColors.background,
                inactiveTrackColor: AppColors.border,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
