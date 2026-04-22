import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/icon_mapper.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_status.dart';
import '../providers/categories_provider.dart';

// Dialog for adding or editing a category
class AddorEditCategoryDialog extends ConsumerStatefulWidget {
  const AddorEditCategoryDialog({super.key, this.categoryToEdit});

  final CategoryEntity? categoryToEdit;

  @override
  ConsumerState<AddorEditCategoryDialog> createState() =>
      _AddorEditCategoryDialogState();
}

class _AddorEditCategoryDialogState
    extends ConsumerState<AddorEditCategoryDialog> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;

  late final ValueNotifier<CategoryStatus> _statusNotifier;
  late final ValueNotifier<IconData> _selectedIconNotifier;
  late final ValueNotifier<bool> _isLoading;

  // List of icons
  late final List<IconData> _availableIcons;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _isLoading = ValueNotifier(false);

    // Icons
    _availableIcons = List.of(IconMapper.availableIcons);

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
      widget.categoryToEdit?.icon ?? _availableIcons.first,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _statusNotifier.dispose();
    _selectedIconNotifier.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _isLoading.value = true;

    final notifier = ref.read(categoriesListProvider.notifier);
    final isEditing = widget.categoryToEdit != null;
    final iconName = IconMapper.toName(_selectedIconNotifier.value);

    bool success;

    if (isEditing) {
      success = await notifier.updateCategory(
        id: widget.categoryToEdit!.id,
        title: _titleController.text.trim(),
        iconName: iconName,
        status: _statusNotifier.value,
      );
    } else {
      success = await notifier.createCategory(
        title: _titleController.text.trim(),
        iconName: iconName,
        status: _statusNotifier.value,
      );
    }

    _isLoading.value = false;

    if (!mounted) return;

    if (success) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing
                ? 'Category updated successfully'
                : 'Category created successfully',
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing
                ? 'Failed to update category'
                : 'Failed to create category',
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
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
              _DialogHeader(isEditing: isEditing),
              const Divider(height: 32, color: AppColors.border),

              _CategoryFieldSection(titleController: _titleController),
              const SizedBox(height: 24),

              _StatusSection(statusNotifier: _statusNotifier),
              const SizedBox(height: 24),

              Flexible(
                child: _IconSelectionSection(
                  selectedIconNotifier: _selectedIconNotifier,
                  availableIcons: _availableIcons,
                ),
              ),
              const SizedBox(height: 32),

              _ActionButtonsSection(
                isLoading: _isLoading,
                isEditing: isEditing,
                onSubmit: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  final bool isEditing;

  const _DialogHeader({required this.isEditing});

  @override
  Widget build(BuildContext context) {
    return Row(
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
          icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
          onPressed: () => context.pop(),
          splashRadius: 20,
        ),
      ],
    );
  }
}

class _CategoryFieldSection extends StatelessWidget {
  final TextEditingController titleController;

  const _CategoryFieldSection({required this.titleController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          controller: titleController,
          hintText: 'e.g. Electrical Repair',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a category name';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _StatusSection extends StatelessWidget {
  final ValueNotifier<CategoryStatus> statusNotifier;

  const _StatusSection({required this.statusNotifier});

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

class _IconSelectionSection extends StatelessWidget {
  final ValueNotifier<IconData> selectedIconNotifier;
  final List<IconData> availableIcons;

  const _IconSelectionSection({
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

class _ActionButtonsSection extends StatelessWidget {
  final ValueNotifier<bool> isLoading;
  final bool isEditing;
  final VoidCallback onSubmit;

  const _ActionButtonsSection({
    required this.isLoading,
    required this.isEditing,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
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
        Expanded(
          child: ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (context, loading, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.background,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: loading ? null : onSubmit,
                child: loading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.background,
                        ),
                      )
                    : Text(
                        isEditing ? 'Save Changes' : 'Create Category',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
