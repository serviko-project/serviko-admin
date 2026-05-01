import 'package:flutter/material.dart';
import 'package:serviko_admin/features/providers/presentation/widgets/provider_details/provider_rejection_dialog.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../providers/domain/entities/provider_entity.dart';
import '../../../../providers/domain/entities/provider_status.dart';
import 'provider_details_card.dart';
import 'provider_section_title.dart';

class ProviderQuickActionsCard extends StatelessWidget {
  final ProviderEntity provider;
  final String? loadingAction;
  final void Function(String action, {String? rejectionReason}) onReviewAction;

  const ProviderQuickActionsCard({
    super.key,
    required this.provider,
    this.loadingAction,
    required this.onReviewAction,
  });

  bool get _anyLoading => loadingAction != null;

  @override
  Widget build(BuildContext context) {
    return ProviderDetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ProviderSectionTitle('Quick Actions'),
          if (provider.status == ProviderStatus.pending) ...[
            _buildPrimaryButton(
              label: 'Approve Provider',
              backgroundColor: AppColors.success,
              onPressed: () => onReviewAction('approve'),
              isLoading: loadingAction == 'approve',
            ),
            const SizedBox(height: 12),
            _buildOutlinedButton(
              label: 'Reject Provider',
              color: AppColors.error,
              onPressed: () => ProviderRejectionDialog.show(
                context,
                onReviewAction: onReviewAction,
              ),
              isLoading: loadingAction == 'reject',
            ),
          ] else if (provider.status == ProviderStatus.approved) ...[
            _buildOutlinedButton(
              label: 'Block Provider',
              color: AppColors.error,
              onPressed: () => onReviewAction('block'),
              isLoading: loadingAction == 'block',
            ),
          ] else if (provider.status == ProviderStatus.rejected) ...[
            _buildPrimaryButton(
              label: 'Approve Provider',
              backgroundColor: AppColors.success,
              onPressed: () => onReviewAction('approve'),
              isLoading: loadingAction == 'approve',
            ),
            if (provider.rejectionReason != null &&
                provider.rejectionReason!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withAlpha(10),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.error.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rejection Reason',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      provider.rejectionReason!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ] else ...[
            // Blocked
            _buildPrimaryButton(
              label: 'Unblock Provider',
              backgroundColor: AppColors.success,
              onPressed: () => onReviewAction('approve'),
              isLoading: loadingAction == 'approve',
            ),
          ],
        ],
      ),
    );
  }

  // Method to build primary action buttons (Approve/Unblock)
  Widget _buildPrimaryButton({
    required String label,
    required Color backgroundColor,
    required VoidCallback onPressed,
    required bool isLoading,
  }) {
    return ElevatedButton(
      onPressed: _anyLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        disabledBackgroundColor: backgroundColor.withAlpha(150),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              label,
              style: const TextStyle(
                color: AppColors.background,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  Widget _buildOutlinedButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
    required bool isLoading,
  }) {
    return OutlinedButton(
      onPressed: _anyLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        disabledForegroundColor: color.withAlpha(150),
        side: BorderSide(color: _anyLoading ? color.withAlpha(150) : color),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            )
          : Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
    );
  }
}
