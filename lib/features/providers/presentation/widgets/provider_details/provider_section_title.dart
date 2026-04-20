import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class ProviderSectionTitle extends StatelessWidget {
  const ProviderSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          letterSpacing: 0.5,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
