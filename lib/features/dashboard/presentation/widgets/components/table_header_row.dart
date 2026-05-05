import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';

// Table Header Row Widget for Recent Applications Table
TableRow buildHeaderRow() {
  return TableRow(
    decoration: const BoxDecoration(
      color: AppColors.surface,
      border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1.0)),
    ),
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 16.0),
        child: Text(
          'PROVIDER',
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Text(
            'PROFESSIONAL TITLE',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Text(
            'STATUS',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Text(
            'ACTION',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    ],
  );
}
