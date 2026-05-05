import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';

class DeleteCategoryDialog extends StatelessWidget {
  final String categoryTitle;

  const DeleteCategoryDialog({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Delete Category',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      content: Text(
        'Are you sure you want to delete "$categoryTitle"? This action cannot be undone.',
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text(
            'Delete',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
