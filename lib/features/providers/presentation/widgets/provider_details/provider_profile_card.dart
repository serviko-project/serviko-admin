import 'package:flutter/material.dart';
import 'package:serviko_admin/core/utils/date_time_utils.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../providers/domain/entities/provider_entity.dart';
import '../../../../providers/domain/entities/provider_status.dart';
import 'provider_details_card.dart';

class ProviderProfileCard extends StatelessWidget {
  final ProviderEntity provider;

  const ProviderProfileCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (provider.status) {
      case ProviderStatus.active:
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle;
        statusText = 'ACTIVE';
        break;
      case ProviderStatus.pending:
        statusColor = AppColors.warning;
        statusIcon = Icons.access_time_filled;
        statusText = 'PENDING APPROVAL';
        break;
      case ProviderStatus.blocked:
        statusColor = AppColors.error;
        statusIcon = Icons.cancel;
        statusText = 'BLOCKED';
        break;
    }

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
                color: provider.status == ProviderStatus.active
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
                          _buildAvatar(),
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
                          _buildStatusBadge(
                            statusText,
                            statusColor,
                            statusIcon,
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
                          _buildContactChip(
                            Icons.phone_outlined,
                            provider.phoneNumber,
                          ),
                          _buildContactChip(
                            Icons.email_outlined,
                            provider.email,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Member since ${DateTimeUtils.formatDate(provider.submittedAt)}',
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

  Widget _buildAvatar() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.background,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.1),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.surface,
            backgroundImage: provider.avatarUrl.isNotEmpty
                ? NetworkImage(provider.avatarUrl)
                : null,
            child: provider.avatarUrl.isEmpty
                ? const Icon(Icons.person, size: 40, color: AppColors.textHint)
                : null,
          ),
        ),
        if (provider.status == ProviderStatus.active)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.background, width: 2),
            ),
            child: const Icon(
              Icons.verified,
              size: 14,
              color: AppColors.textOnPrimary,
            ),
          ),
      ],
    );
  }

  Widget _buildMetaInfoRow() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (provider.rating != null && provider.rating! > 0)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star_rounded,
                size: 18,
                color: AppColors.warning,
              ),
              const SizedBox(width: 4),
              Text(
                '${provider.rating}',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        if (provider.locationName.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.textHint,
              ),
              const SizedBox(width: 4),
              Text(
                provider.locationName,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.work_outline_rounded,
              size: 16,
              color: AppColors.textHint,
            ),
            const SizedBox(width: 4),
            Text(
              '${provider.jobsCompleted} Jobs completed',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
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
      ],
    );
  }

  Widget _buildStatusBadge(String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
