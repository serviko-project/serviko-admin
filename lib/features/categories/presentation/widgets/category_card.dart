import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_status.dart';
import '../providers/categories_provider.dart';
import 'add_or_edit_category_dialog.dart';
import 'category_card/category_card_actions.dart';
import 'category_card/category_card_header.dart';
import 'category_card/delete_category_dialog.dart';

// Category Card Widget
class CategoryCard extends ConsumerStatefulWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryEntity category;

  @override
  ConsumerState<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends ConsumerState<CategoryCard> {
  late final ValueNotifier<bool> _isHovered;

  @override
  void initState() {
    super.initState();
    _isHovered = ValueNotifier(false);
  }

  @override
  void dispose() {
    _isHovered.dispose();
    super.dispose();
  }

  // Handle edit
  void _onEdit() {
    showDialog(
      context: context,
      builder: (context) =>
          AddorEditCategoryDialog(categoryToEdit: widget.category),
    );
  }

  // Handle delete
  Future<void> _onDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) =>
          DeleteCategoryDialog(categoryTitle: widget.category.title),
    );

    if (confirm != true || !mounted) return;

    final success = await ref
        .read(categoriesListProvider.notifier)
        .deleteCategory(widget.category.id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? '"${widget.category.title}" deleted'
              : 'Failed to delete category',
        ),
        backgroundColor: success ? AppColors.success : AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Handle status toggle
  Future<void> _onToggleStatus(bool val) async {
    final success = await ref
        .read(categoriesListProvider.notifier)
        .toggleStatus(widget.category);

    if (!mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update status'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isActive = widget.category.status == CategoryStatus.active;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _isHovered.value = true,
      onExit: (_) => _isHovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isHovered,
        builder: (context, isHovered, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isHovered
                    ? AppColors.primary.withAlpha(80)
                    : AppColors.primary.withAlpha(30),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha(isHovered ? 40 : 20),
                  blurRadius: isHovered ? 24 : 16,
                  spreadRadius: 0,
                  offset: Offset(0, isHovered ? 8 : 4),
                ),
              ],
            ),
            child: Opacity(
              opacity: isActive ? 1.0 : 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryCardHeader(
                    category: widget.category,
                    onToggleStatus: _onToggleStatus,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.category.title,
                    style: const TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${widget.category.providerCount} providers',
                    style: const TextStyle(
                      fontSize: 10,
                      letterSpacing: 0.25,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  const Divider(
                    height: 16,
                    thickness: 1,
                    color: AppColors.border,
                  ),
                  CategoryCardActions(onEdit: _onEdit, onDelete: _onDelete),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
