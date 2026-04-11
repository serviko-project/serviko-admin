import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';

// Admin Branding Side of the Login Screen
class AdminBrandingSide extends StatelessWidget {
  const AdminBrandingSide({super.key, required this.isDesktop});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sidebarBackground,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.xxl,
        vertical: isDesktop ? AppSizes.xxl : AppSizes.xxl * 1.5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Text(
            'SERVIKO ADMIN',
            style: AppTextStyles.h1.copyWith(
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),

          // Lottie Animation
          LottieBuilder.asset(
            "assets/animations/login_animation.json",
            height: isDesktop ? 400 : 350,
          ),

          SizedBox(height: AppSizes.sm),

          // Subheading
          Text(
            'Manage Serviko with Ease',
            style: AppTextStyles.h2.copyWith(
              color: Colors.white,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.sm),

          // Description
          Text(
            'Your control center for categories, providers and platform operations.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
