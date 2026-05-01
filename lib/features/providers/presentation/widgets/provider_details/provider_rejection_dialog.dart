import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';

class ProviderRejectionDialog extends StatefulWidget {
  const ProviderRejectionDialog({super.key, required this.onReviewAction});

  final void Function(String action, {String? rejectionReason}) onReviewAction;

  // Method to show rejection reason dialog
  static void show(
    BuildContext context, {
    required void Function(String action, {String? rejectionReason})
    onReviewAction,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => ProviderRejectionDialog(onReviewAction: onReviewAction),
    );
  }

  @override
  State<ProviderRejectionDialog> createState() =>
      _ProviderRejectionDialogState();
}

class _ProviderRejectionDialogState extends State<ProviderRejectionDialog> {
  late final GlobalKey<FormState> formkey;
  late TextEditingController _controller;

  @override
  void initState() {
    formkey = GlobalKey<FormState>();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Reject Provider',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please provide a reason for rejection.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            const SizedBox(height: 16),
            Form(
              key: formkey,
              child: TextFormField(
                controller: _controller,
                maxLines: 3,
                style: const TextStyle(fontSize: 13),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Rejection reason cannot be empty'
                    : null,
                decoration: InputDecoration(
                  hintText: 'Enter rejection reason...',
                  hintStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(fontSize: 13)),
        ),
        ElevatedButton(
          onPressed: () {
            if (formkey.currentState!.validate()) {
              final reason = _controller.text.trim();
              Navigator.pop(context);
              widget.onReviewAction('reject', rejectionReason: reason);
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
          child: const Text(
            'Reject',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
