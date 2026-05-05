import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';

// Action Cell Widget in Table Row
class ActionCell extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ActionCell({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.3,
        ),
      ),
    );
  }
}
