import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';

class DialogHeader extends StatelessWidget {
  final bool isEditing;

  const DialogHeader({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isEditing ? 'Edit Category' : 'Add New Category',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            letterSpacing: 0.5,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
          onPressed: () => context.pop(),
          splashRadius: 20,
        ),
      ],
    );
  }
}
