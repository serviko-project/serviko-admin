import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/category_request_status.dart';

class CategoryRequestStatusBadge extends StatelessWidget {
  final CategoryRequestStatus status;

  const CategoryRequestStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case CategoryRequestStatus.approved:
        color = AppColors.success;
        label = 'Approved';
        break;
      case CategoryRequestStatus.pending:
        color = AppColors.warning;
        label = 'Pending';
        break;
      case CategoryRequestStatus.declined:
        color = AppColors.error;
        label = 'Declined';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
