import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';

class CategoryCardActions extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CategoryCardActions({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Tooltip(
              message: 'Edit Category',
              child: InkWell(
                onTap: onEdit,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: 'Delete Category',
              child: InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.error.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    size: 18,
                    color: AppColors.error,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Tooltip(
          message: 'Drag to reorder',
          child: Icon(
            Icons.drag_indicator_rounded,
            color: AppColors.border,
            size: 20,
          ),
        ),
      ],
    );
  }
}
