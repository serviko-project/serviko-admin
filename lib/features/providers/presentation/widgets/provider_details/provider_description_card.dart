import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/features/providers/domain/entities/provider_entity.dart';
import 'package:serviko_admin/features/providers/presentation/widgets/provider_details/provider_section_title.dart';

class ProviderDescriptionCard extends StatelessWidget {
  final ProviderEntity provider;

  const ProviderDescriptionCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    if (provider.description.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProviderSectionTitle('Provider Description'),
        const SizedBox(height: 7),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(12),
            border: const Border(
              left: BorderSide(color: AppColors.primary, width: 4.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.md,
            horizontal: AppSizes.lg,
          ),
          child: Text(
            provider.description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
