import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/category_status.dart';
import 'add_category_dialog.dart';

// Category Card Widget
class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryEntity category;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
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
                  // Icon & Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(20),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            widget.category.icon,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            isActive ? 'ACTIVE' : 'INACTIVE',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              color: isActive
                                  ? AppColors.textSecondary
                                  : AppColors.textHint,
                            ),
                          ),
                          const SizedBox(width: 3),

                          // Status Toggle
                          Transform.scale(
                            scale: 0.65,
                            child: Switch(
                              value: isActive,
                              onChanged: (val) {},
                              activeTrackColor: AppColors.success,
                              inactiveThumbColor: AppColors.background,
                              inactiveTrackColor: AppColors.border,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Title & Subtitle
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

                  // Provider Count
                  Text(
                    '${widget.category.providerCount} providers',
                    style: const TextStyle(
                      fontSize: 10,
                      letterSpacing: 0.25,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const Spacer(),

                  //
                  const Divider(
                    height: 16,
                    thickness: 1,
                    color: AppColors.border,
                  ),

                  // Action Buttons & Drag Handle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Edit Button
                          Tooltip(
                            message: 'Edit Category',
                            child: InkWell(
                              onTap: () async {
                                final result = await showDialog(
                                  context: context,
                                  builder: (context) => AddorEditCategoryDialog(
                                    categoryToEdit: widget.category,
                                  ),
                                );
                                if (result != null) {
                                  // Update category
                                }
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withAlpha(20),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.edit_rounded,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Delete Button
                          Tooltip(
                            message: 'Delete Category',
                            child: InkWell(
                              onTap: () async {
                                final confirm = await showDeleteAlertDialogue(
                                  context,
                                );

                                if (confirm == true) {
                                  // Delete category
                                }
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.error.withAlpha(20),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.delete_outline_rounded,
                                  size: 18,
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Tooltip(
                        message: 'Drag to reorder',
                        child: Icon(
                          Icons.drag_indicator_rounded,
                          color: AppColors.border,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Show delete confirmation dialog
  Future<bool?> showDeleteAlertDialogue(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Category',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${widget.category.title}"? This action cannot be undone.',
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
