import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';

TableRow buildCategoryRequestTableHeader() {
  // Header Cell
  Widget buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
      child: Align(
        alignment: text == 'ACTIONS' ? Alignment.center : Alignment.centerLeft,
        child: Text(
          text,
          textAlign: text == 'ACTIONS' ? TextAlign.center : TextAlign.left,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  return TableRow(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.divider, width: 1.0)),
    ),
    children: [
      // Checkbox
      const Padding(
        padding: EdgeInsets.only(
          left: AppSizes.lg,
          top: AppSizes.md,
          bottom: AppSizes.md,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.check_box_outline_blank,
            color: AppColors.border,
            size: AppSizes.iconMd,
          ),
        ),
      ),
      // Table Headers
      buildHeaderCell('PROVIDER'),
      buildHeaderCell('REQUESTED CATEGORY'),
      buildHeaderCell('DESCRIPTION'),
      buildHeaderCell('SUBMITTED'),
      buildHeaderCell('STATUS'),
      buildHeaderCell('ACTIONS'),
    ],
  );
}
