import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entities/category_request_entity.dart';
import '../providers/category_request_provider.dart';
import '../../../categories/presentation/widgets/add_edit_category/dialog_header.dart';

class DeclineCategoryRequestDialog extends ConsumerStatefulWidget {
  final CategoryRequestEntity request;

  const DeclineCategoryRequestDialog({super.key, required this.request});
  @override
  ConsumerState<DeclineCategoryRequestDialog> createState() =>
      _DeclineCategoryRequestDialogState();
}

class _DeclineCategoryRequestDialogState
    extends ConsumerState<DeclineCategoryRequestDialog> {
  late final TextEditingController _noteController;
  late final GlobalKey<FormState> _formKey;
  late final ValueNotifier<bool> _isLoading;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _noteController = TextEditingController();
    _isLoading = ValueNotifier(false);
  }

  @override
  void dispose() {
    _noteController.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  Future<void> _decline() async {
    if (!_formKey.currentState!.validate()) return;

    _isLoading.value = true;
    final note = _noteController.text.trim();
    final notifier = ref.read(categoryRequestControllerProvider.notifier);

    try {
      await notifier.declineRequest(widget.request.id, note);

      final requestState = ref.read(categoryRequestControllerProvider);
      final success = !requestState.hasError;

      if (!mounted) return;

      if (success) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Category request declined'),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        _isLoading.value = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to decline: ${requestState.error}'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      _isLoading.value = false;
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to decline: $e'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.background,
      insetPadding: const EdgeInsets.all(AppSizes.lg),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const DialogHeader(title: 'Decline Request'),
              const Divider(height: 32, color: AppColors.border),

              Text(
                'Are you sure you want to decline the request for "${widget.request.requestedCategory}"?',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: AppSizes.lg),

              // Admin Note Field
              const Text(
                'REASON FOR DECLINING',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _noteController,
                hintText: 'Enter reason to help the provider understand...',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a reason for declining';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppSizes.xl),

              // Action buttons
              ValueListenableBuilder<bool>(
                valueListenable: _isLoading,
                builder: (context, loading, _) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: loading ? null : () => context.pop(),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: loading ? null : _decline,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: loading
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Decline Request',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
