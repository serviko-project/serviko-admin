import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/provider_status.dart';

// Provider Status Badge Widget
class StatusBadge extends StatelessWidget {
  final ProviderStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status) {
      case ProviderStatus.active:
        backgroundColor = AppColors.primary.withAlpha(20);
        textColor = AppColors.primary;
        label = 'ACTIVE';
        break;
      case ProviderStatus.pending:
        backgroundColor = AppColors.warning.withAlpha(30);
        textColor = AppColors.warning;
        label = 'PENDING';
        break;
      case ProviderStatus.blocked:
        backgroundColor = AppColors.error.withAlpha(30);
        textColor = AppColors.error;
        label = 'BLOCKED';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
