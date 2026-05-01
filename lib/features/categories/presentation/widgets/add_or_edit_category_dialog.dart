import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/icon_mapper.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_status.dart';
import '../providers/categories_provider.dart';
import 'add_edit_category/action_buttons_section.dart';
import 'add_edit_category/category_field_section.dart';
import 'add_edit_category/dialog_header.dart';
import 'add_edit_category/icon_selection_section.dart';
import 'add_edit_category/status_section.dart';

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
              DialogHeader(isEditing: isEditing),
              const Divider(height: 32, color: AppColors.border),
              CategoryFieldSection(titleController: _titleController),
              const SizedBox(height: 24),
              StatusSection(statusNotifier: _statusNotifier),
              const SizedBox(height: 24),
              Flexible(
                child: IconSelectionSection(
                  selectedIconNotifier: _selectedIconNotifier,
                  availableIcons: _availableIcons,
                ),
              ),
              const SizedBox(height: 32),
              ActionButtonsSection(
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
