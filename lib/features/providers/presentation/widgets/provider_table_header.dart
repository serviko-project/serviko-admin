import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

TableRow buildProviderTableHeader() {
  // Header Cell Builder
  Widget buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
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
        padding: EdgeInsets.only(left: 24, top: 16, bottom: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.check_box_outline_blank,
            color: AppColors.border,
            size: 20,
          ),
        ),
      ),
      // Header Cells
      buildHeaderCell('PROVIDER'),
      buildHeaderCell('CATEGORIES'),
      buildHeaderCell('SUBMITTED'),
      buildHeaderCell('RATING'),
      buildHeaderCell('JOBS'),
      buildHeaderCell('STATUS'),
    ],
  );
}
