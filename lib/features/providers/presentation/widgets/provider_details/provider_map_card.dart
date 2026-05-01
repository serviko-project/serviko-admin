import 'package:flutter/material.dart';
import 'package:serviko_admin/features/providers/presentation/widgets/provider_details/provider_section_title.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../providers/domain/entities/provider_entity.dart';

class ProviderMapCard extends StatelessWidget {
  const ProviderMapCard({super.key, required this.provider});

  final ProviderEntity provider;

  @override
  Widget build(BuildContext context) {
    // Hide if no location data
    if (provider.latitude == null || provider.longitude == null) {
      return const SizedBox.shrink();
    }

    final radiusText = provider.coverageRadiusKm != null
        ? '${provider.coverageRadiusKm!.toStringAsFixed(0)} km radius'
        : 'Coverage area not set';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: ProviderSectionTitle("Service Area"),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.textSecondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              const Center(
                child: Icon(Icons.map, size: 100, color: AppColors.textHint),
              ),
              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.primary),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${provider.latitude!.toStringAsFixed(4)}, ${provider.longitude!.toStringAsFixed(4)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            radiusText,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
