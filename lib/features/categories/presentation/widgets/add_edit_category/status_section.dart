import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/features/categories/domain/entities/category_status.dart';

class StatusSection extends StatelessWidget {
  final ValueNotifier<CategoryStatus> statusNotifier;

  const StatusSection({super.key, required this.statusNotifier});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.border.withAlpha(40),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withAlpha(60), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'STATUS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: AppColors.textSecondary,
            ),
          ),
          ValueListenableBuilder<CategoryStatus>(
            valueListenable: statusNotifier,
            builder: (context, status, child) {
              final bool isActive = status == CategoryStatus.active;
              return Row(
                children: [
                  Transform.scale(
                    scale: 0.75,
                    child: Switch(
                      value: isActive,
                      onChanged: (val) {
                        statusNotifier.value = val
                            ? CategoryStatus.active
                            : CategoryStatus.inactive;
                      },
                      activeTrackColor: AppColors.success,
                      inactiveTrackColor: AppColors.border,
                      inactiveThumbColor: AppColors.background,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isActive ? AppColors.success : AppColors.textHint,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
