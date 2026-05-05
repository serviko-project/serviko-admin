import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/features/providers/domain/entities/provider_status.dart';

class ProviderAvatar extends StatelessWidget {
  final String? avatarUrl;
  final ProviderStatus status;

  const ProviderAvatar({super.key, this.avatarUrl, required this.status});

  @override
  Widget build(BuildContext context) {
    final hasAvatar = avatarUrl != null && avatarUrl!.isNotEmpty;
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
            backgroundImage: hasAvatar ? NetworkImage(avatarUrl!) : null,
            child: !hasAvatar
                ? const Icon(Icons.person, size: 40, color: AppColors.textHint)
                : null,
          ),
        ),
        if (status == ProviderStatus.approved)
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
}
