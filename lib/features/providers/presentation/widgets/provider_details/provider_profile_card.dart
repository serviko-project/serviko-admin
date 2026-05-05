import 'package:flutter/material.dart';
import 'package:serviko_admin/core/utils/date_time_utils.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../providers/domain/entities/provider_entity.dart';
import '../../../../providers/domain/entities/provider_status.dart';
import 'profile_card/provider_avatar.dart';
import 'profile_card/provider_contact_chip.dart';
import 'profile_card/provider_status_badge.dart';
import 'provider_details_card.dart';

class ProviderProfileCard extends StatelessWidget {
  final ProviderEntity provider;

  const ProviderProfileCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final (statusColor, statusIcon, statusText) = _statusStyle(provider.status);

    return ProviderDetailsCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Accent Line
              Container(
                width: 6,
                color: provider.status == ProviderStatus.approved
                    ? AppColors.primary
                    : statusColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Avatar & Info + Status Badge
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProviderAvatar(
                            avatarUrl: provider.avatarUrl,
                            status: provider.status,
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                if (provider.professionalTitle.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    provider.professionalTitle,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 12),
                                _buildMetaInfoRow(),
                              ],
                            ),
                          ),
                          ProviderStatusBadge(
                            text: statusText,
                            color: statusColor,
                            icon: statusIcon,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Divider(color: AppColors.divider, height: 1),
                      const SizedBox(height: 16),

                      // Bottom Row: Contact Info & Joined Date
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          ProviderContactChip(
                            icon: Icons.phone_outlined,
                            text: provider.phoneNumber,
                          ),
                          ProviderContactChip(
                            icon: Icons.email_outlined,
                            text: provider.email,
                          ),
                          const SizedBox(width: 8),
                          if (provider.submittedAt != null)
                            Text(
                              'Member since ${DateTimeUtils.formatDate(provider.submittedAt!)}',
                              style: const TextStyle(
                                color: AppColors.textHint,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
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
      ),
    );
  }

  Widget _buildMetaInfoRow() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.timeline, size: 16, color: AppColors.textHint),
            const SizedBox(width: 4),
            Text(
              '${provider.yearsOfExperience} Years Experience',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
        if (provider.services.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.category_outlined,
                size: 16,
                color: AppColors.textHint,
              ),
              const SizedBox(width: 4),
              Text(
                '${provider.services.length} Service${provider.services.length > 1 ? 's' : ''}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
      ],
    );
  }

  (Color, IconData, String) _statusStyle(ProviderStatus status) {
    return switch (status) {
      ProviderStatus.approved => (
        AppColors.success,
        Icons.check_circle,
        'APPROVED',
      ),
      ProviderStatus.pending => (
        AppColors.warning,
        Icons.access_time_filled,
        'PENDING APPROVAL',
      ),
      ProviderStatus.rejected => (
        Colors.orange.shade800,
        Icons.cancel,
        'REJECTED',
      ),
      ProviderStatus.blocked => (AppColors.error, Icons.block, 'BLOCKED'),
    };
  }
}
