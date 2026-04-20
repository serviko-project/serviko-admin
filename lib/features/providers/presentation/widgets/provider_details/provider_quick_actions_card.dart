import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../providers/domain/entities/provider_entity.dart';
import '../../../../providers/domain/entities/provider_status.dart';
import 'provider_details_card.dart';
import 'provider_section_title.dart';

class ProviderQuickActionsCard extends StatelessWidget {
  final ProviderEntity provider;
  final void Function(ProviderStatus) onUpdateStatus;

  const ProviderQuickActionsCard({
    super.key,
    required this.provider,
    required this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderDetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ProviderSectionTitle('Quick Actions'),
          if (provider.status == ProviderStatus.pending) ...[
            ElevatedButton(
              onPressed: () => onUpdateStatus(ProviderStatus.active),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Approve Provider',
                style: TextStyle(
                  color: AppColors.background,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => onUpdateStatus(ProviderStatus.blocked),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Reject Provider',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ] else if (provider.status == ProviderStatus.active) ...[
            OutlinedButton(
              onPressed: () => onUpdateStatus(ProviderStatus.blocked),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Block Provider',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ] else ...[
            ElevatedButton(
              onPressed: () => onUpdateStatus(ProviderStatus.active),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Unblock Provider',
                style: TextStyle(
                  color: AppColors.background,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: AppColors.border),
            ),
            child: const Text(
              'Request More Info',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
