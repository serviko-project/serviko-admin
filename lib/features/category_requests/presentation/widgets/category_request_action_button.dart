import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';

class CategoryRequestActionButton extends StatelessWidget {
  const CategoryRequestActionButton({
    super.key,
    required this.label,
    required this.isFilled,
    required this.color,
    required this.onTap,
  });

  final String label;
  final bool isFilled;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isFilled ? color : Colors.transparent,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: isFilled ? Colors.white : color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
