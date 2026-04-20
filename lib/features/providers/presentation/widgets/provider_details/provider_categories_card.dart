import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../providers/domain/entities/provider_entity.dart';
import 'provider_section_title.dart';

class ProviderCategoriesCard extends StatelessWidget {
  final ProviderEntity provider;

  const ProviderCategoriesCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderSectionTitle('Service Categories Requested'),
        Row(
          children: provider.categories
              .map(
                (category) => Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Chip(
                    label: Text(category, style: const TextStyle(fontSize: 13)),
                    avatar: const Icon(Icons.category_rounded, size: 16),
                    backgroundColor: AppColors.background,
                    side: const BorderSide(color: AppColors.border),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
