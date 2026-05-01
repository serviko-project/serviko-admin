import 'package:flutter/material.dart';
import 'package:serviko_admin/core/utils/date_time_utils.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../providers/domain/entities/provider_entity.dart';
import '../../../../providers/domain/entities/provider_status.dart';
import 'provider_details_card.dart';
import 'provider_section_title.dart';

class ProviderApplicationHistoryCard extends StatelessWidget {
  const ProviderApplicationHistoryCard({super.key, required this.provider});

  final ProviderEntity provider;

  @override
  Widget build(BuildContext context) {
    return ProviderDetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProviderSectionTitle('Application History'),
          _buildTimelineStep(
            title: 'Application submitted',
            subtitle: provider.submittedAt != null
                ? DateTimeUtils.formatDate(provider.submittedAt!)
                : 'Unknown',
            isActive: true,
            isLast: false,
          ),
          if (provider.status == ProviderStatus.pending) ...[
            _buildTimelineStep(
              title: 'Awaiting admin approval',
              subtitle: 'Current Stage',
              isActive: false,
              isLast: true,
            ),
          ] else if (provider.status == ProviderStatus.approved) ...[
            _buildTimelineStep(
              title: 'Approved',
              subtitle: provider.reviewedAt != null
                  ? DateTimeUtils.formatDate(provider.reviewedAt!)
                  : '',
              isActive: true,
              isLast: true,
            ),
          ] else if (provider.status == ProviderStatus.rejected) ...[
            _buildTimelineStep(
              title: 'Rejected',
              subtitle: provider.reviewedAt != null
                  ? DateTimeUtils.formatDate(provider.reviewedAt!)
                  : '',
              isActive: true,
              isError: true,
              isLast: true,
            ),
          ] else if (provider.status == ProviderStatus.blocked) ...[
            _buildTimelineStep(
              title: 'Blocked',
              subtitle: provider.reviewedAt != null
                  ? DateTimeUtils.formatDate(provider.reviewedAt!)
                  : '',
              isActive: true,
              isError: true,
              isLast: true,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
    required String title,
    required String subtitle,
    required bool isActive,
    required bool isLast,
    bool isError = false,
  }) {
    final color = isError
        ? AppColors.error
        : (isActive ? AppColors.primary : AppColors.textHint);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 3),
              ),
              child: Center(
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? color : Colors.transparent,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(width: 2, height: 40, color: AppColors.border),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: isError ? AppColors.error : AppColors.textHint,
                  fontSize: 11,
                  fontStyle: subtitle == 'Current Stage'
                      ? FontStyle.italic
                      : FontStyle.normal,
                ),
              ),
              if (!isLast) const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
