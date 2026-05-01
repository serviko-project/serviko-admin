import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../providers/domain/entities/provider_entity.dart';
import 'provider_details_card.dart';

// Day of week for mapping
const _dayNames = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

class ProviderAvailabilityCard extends StatelessWidget {
  final ProviderEntity provider;

  const ProviderAvailabilityCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    if (provider.availability.isEmpty) {
      return const SizedBox.shrink();
    }

    return ProviderDetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.access_time, color: AppColors.primary, size: 20),
                SizedBox(width: 8),
                Text(
                  'Weekly Availability',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          ...([
            ...provider.availability,
          ]..sort((a, b) => a.dayOfWeek.compareTo(b.dayOfWeek))).map((slot) {
            final dayName = slot.dayOfWeek >= 1 && slot.dayOfWeek <= 7
                ? _dayNames[slot.dayOfWeek - 1]
                : 'Day ${slot.dayOfWeek}';

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      dayName,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      slot.isEnabled
                          ? '${slot.startTime} - ${slot.endTime}'
                          : 'Not Available',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: slot.isEnabled
                            ? AppColors.textPrimary
                            : AppColors.textHint,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
