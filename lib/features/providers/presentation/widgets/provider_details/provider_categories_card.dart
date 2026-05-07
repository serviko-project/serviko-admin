import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/icon_mapper.dart';
import '../../../../providers/domain/entities/provider_entity.dart';
import 'provider_section_title.dart';

class ProviderCategoriesCard extends StatelessWidget {
  final ProviderEntity provider;

  const ProviderCategoriesCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    if (provider.services.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderSectionTitle('Service Categories'),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: provider.services
              .map(
                (service) => Chip(
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  label: Text(
                    '${service.categoryTitle} • ₹${service.basePricePerHour.toStringAsFixed(0)}/hr',
                    style: const TextStyle(fontSize: 12),
                  ),
                  avatar: Icon(
                    IconMapper.fromName(service.categoryIcon),
                    size: 16,
                  ),
                  backgroundColor: AppColors.background,
                  side: const BorderSide(color: AppColors.border),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
