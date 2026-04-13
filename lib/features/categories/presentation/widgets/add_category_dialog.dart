import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_status.dart';

// Dialog for adding or editing a category
class AddorEditCategoryDialog extends StatefulWidget {
  const AddorEditCategoryDialog({super.key, this.categoryToEdit});

  final CategoryEntity? categoryToEdit;

  @override
  State<AddorEditCategoryDialog> createState() =>
      _AddorEditCategoryDialogState();
}

class _AddorEditCategoryDialogState extends State<AddorEditCategoryDialog> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;

  late final ValueNotifier<CategoryStatus> _statusNotifier;
  late final ValueNotifier<IconData> _selectedIconNotifier;

  // List of icons
  late final List<IconData> _availableIcons;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();

    // Icons
    _availableIcons = [
      Icons.flash_on_rounded,
      Icons.home_rounded,
      Icons.build_rounded,
      Icons.water_drop_rounded,
      Icons.ac_unit_rounded,
      Icons.local_shipping_rounded,
      Icons.security_rounded,
      Icons.palette_rounded,
      Icons.cleaning_services_rounded,
      Icons.yard_rounded,
      Icons.computer_rounded,
      Icons.directions_car_rounded,
      Icons.format_paint_rounded,
      Icons.iron_rounded,
      Icons.pets_rounded,
      Icons.engineering_rounded,
      Icons.camera_alt_rounded,
      Icons.spa_rounded,
      Icons.fitness_center_rounded,
      Icons.fastfood_rounded,
      Icons.shopping_bag_rounded,
      Icons.medical_services_rounded,
      Icons.chair_rounded,
      Icons.inventory_2_rounded,
    ];

    // Editing -> Pre fill Icon
    if (widget.categoryToEdit?.icon != null) {
      final existingIcon = widget.categoryToEdit!.icon;

      if (!_availableIcons.any(
        (icon) => icon.codePoint == existingIcon.codePoint,
      )) {
        _availableIcons.insert(0, existingIcon);
      }
    }

    _titleController = TextEditingController(
      text: widget.categoryToEdit?.title ?? '',
    );
    _statusNotifier = ValueNotifier(
      widget.categoryToEdit?.status ?? CategoryStatus.active,
    );
    _selectedIconNotifier = ValueNotifier(
      widget.categoryToEdit?.icon ?? Icons.flash_on_rounded,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _statusNotifier.dispose();
    _selectedIconNotifier.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newCategoryDetails = {
        'id': widget.categoryToEdit?.id,
        'title': _titleController.text.trim(),
        'icon': _selectedIconNotifier.value,
        'status': _statusNotifier.value,
      };

      // Pop the Dialog
      context.pop(newCategoryDetails);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.categoryToEdit != null;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing ? 'Edit Category' : 'Add New Category',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => context.pop(),
                    splashRadius: 20,
                  ),
                ],
              ),
              const Divider(height: 32, color: AppColors.border),

              // Category Name Field
              const Text(
                'CATEGORY NAME',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),

              CustomTextField(
                controller: _titleController,
                hintText: 'e.g. Electrical Repair',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Status Toggle
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.border.withAlpha(40),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.border.withAlpha(60),
                    width: 1,
                  ),
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
                      valueListenable: _statusNotifier,
                      builder: (context, status, child) {
                        final bool isActive = status == CategoryStatus.active;
                        return Row(
                          children: [
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: isActive,
                                onChanged: (val) {
                                  _statusNotifier.value = val
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
                                color: isActive
                                    ? AppColors.success
                                    : AppColors.textHint,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Category Icon Selection
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

              // Icon Selection Grid
              ValueListenableBuilder<IconData>(
                valueListenable: _selectedIconNotifier,
                builder: (context, selectedIcon, child) {
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _availableIcons.map((icon) {
                      final isSelected =
                          selectedIcon.codePoint == icon.codePoint;
                      return InkWell(
                        onTap: () => _selectedIconNotifier.value = icon,
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

              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => context.pop(),
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

                  // Create / Save Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.background,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _submit,
                      child: Text(
                        isEditing ? 'Save Changes' : 'Create Category',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
