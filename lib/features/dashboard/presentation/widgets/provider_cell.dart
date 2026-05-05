import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';

// Provider Cell Widget in Table Row
class ProviderCell extends StatelessWidget {
  final String name;
  final String email;
  final String initials;
  final String? profileImageUrl;

  const ProviderCell({
    super.key,
    required this.name,
    required this.email,
    required this.initials,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (profileImageUrl != null && profileImageUrl!.isNotEmpty)
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(profileImageUrl!),
            backgroundColor: AppColors.primary.withAlpha(10),
          )
        else
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        const SizedBox(width: AppSizes.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Text(
                  email,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textHint,
                    letterSpacing: 0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
