import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';

// Action Cell Widget in Table Row
class ActionCell extends StatelessWidget {
  const ActionCell({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      child: const Text(
        'REVIEW',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.3,
        ),
      ),
    );
  }
}
