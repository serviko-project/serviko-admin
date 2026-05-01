import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/widgets/custom_text_field.dart';

class CategoryFieldSection extends StatelessWidget {
  final TextEditingController titleController;

  const CategoryFieldSection({super.key, required this.titleController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CATEGORY NAME',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: titleController,
          hintText: 'e.g. Electrical Repair',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a category name';
            }
            return null;
          },
        ),
      ],
    );
  }
}
