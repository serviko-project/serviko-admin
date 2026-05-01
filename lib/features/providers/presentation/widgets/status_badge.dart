import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/provider_status.dart';

// Provider Status Badge Widget
class StatusBadge extends StatelessWidget {
  final ProviderStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (backgroundColor, textColor, label) = _statusStyle(status);

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

  (Color, Color, String) _statusStyle(ProviderStatus status) {
    return switch (status) {
      ProviderStatus.approved => (
        AppColors.primary.withAlpha(20),
        AppColors.primary,
        'APPROVED',
      ),
      ProviderStatus.pending => (
        AppColors.warning.withAlpha(30),
        AppColors.warning,
        'PENDING',
      ),
      ProviderStatus.rejected => (
        Colors.orange.withAlpha(30),
        Colors.orange.shade800,
        'REJECTED',
      ),
      ProviderStatus.blocked => (
        AppColors.error.withAlpha(30),
        AppColors.error,
        'BLOCKED',
      ),
    };
  }
}
