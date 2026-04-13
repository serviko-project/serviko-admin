import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';

// Top Header Widget for Dashboard
class TopHeader extends StatelessWidget {
  const TopHeader({super.key, required this.isDesktop, required this.title});

  final bool isDesktop;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.xl,
        vertical: AppSizes.md,
      ),
      child: Row(
        children: [
          // Mobile Menu Icon
          if (!isDesktop) ...[
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            const SizedBox(width: AppSizes.md),
          ],

          // Page Title
          Text(
            title,
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(width: AppSizes.xl),

          const Spacer(),

          // Notification Bell
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),

          // Separator line
          Container(
            height: 32,
            width: 1,
            color: AppColors.border,
            margin: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          ),

          // Header Profile
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Serviko Admin',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Administrator',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSizes.md),
              const CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
