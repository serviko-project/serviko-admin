import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String badgeText;
  final Color badgeColor;
  final IconData icon;
  final Color iconColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.badgeText,
    required this.badgeColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: iconColor.withAlpha(60), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  color: iconColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.2,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                value,
                style: AppTextStyles.h1.copyWith(fontSize: 26, height: 1.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
