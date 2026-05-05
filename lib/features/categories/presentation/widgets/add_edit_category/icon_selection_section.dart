import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';

class IconSelectionSection extends StatelessWidget {
  final ValueNotifier<IconData> selectedIconNotifier;
  final List<IconData> availableIcons;

  const IconSelectionSection({
    super.key,
    required this.selectedIconNotifier,
    required this.availableIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'CATEGORY ICON',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Flexible(
          child: SingleChildScrollView(
            child: ValueListenableBuilder<IconData>(
              valueListenable: selectedIconNotifier,
              builder: (context, selectedIcon, child) {
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: availableIcons.map((icon) {
                    final isSelected = selectedIcon.codePoint == icon.codePoint;
                    return InkWell(
                      onTap: () => selectedIconNotifier.value = icon,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withAlpha(20)
                              : AppColors.border.withAlpha(20),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          icon,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          size: 24,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
