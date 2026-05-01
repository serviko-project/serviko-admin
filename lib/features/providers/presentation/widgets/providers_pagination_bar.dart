import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProvidersPaginationBar extends StatelessWidget {
  final int totalItems;
  final int currentPage;
  final int itemsPerPage;
  final ValueChanged<int> onPageChanged;

  const ProvidersPaginationBar({
    super.key,
    required this.totalItems,
    this.currentPage = 1,
    this.itemsPerPage = 20,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final totalPages = (totalItems / itemsPerPage).ceil();
    final startItem = ((currentPage - 1) * itemsPerPage) + 1;
    final endItem = (startItem + itemsPerPage - 1) > totalItems
        ? totalItems
        : (startItem + itemsPerPage - 1);

    if (totalItems == 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Showing $startItem-$endItem of $totalItems providers',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 24),
            Row(
              children: [
                // Previous page
                IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 20,
                    color: AppColors.textHint,
                  ),
                  onPressed: currentPage > 1
                      ? () => onPageChanged(currentPage - 1)
                      : null,
                  splashRadius: 20,
                ),

                // Page buttons
                ..._buildPageButtons(totalPages),

                // Next page
                IconButton(
                  icon: const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: AppColors.textHint,
                  ),
                  onPressed: currentPage < totalPages
                      ? () => onPageChanged(currentPage + 1)
                      : null,
                  splashRadius: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageButtons(int totalPages) {
    final pages = <int>[];

    // First Page
    pages.add(1);

    // Show pages around current
    for (int i = currentPage - 1; i <= currentPage + 1; i++) {
      if (i > 1 && i < totalPages) pages.add(i);
    }

    // Show last page
    if (totalPages > 1) pages.add(totalPages);

    final uniquePages = pages.toSet().toList()..sort();
    final widgets = <Widget>[];

    for (int i = 0; i < uniquePages.length; i++) {
      // Add ellipsis if gap between pages
      if (i > 0 && uniquePages[i] - uniquePages[i - 1] > 1) {
        widgets.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '...',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        );
      }

      widgets.add(
        _PageButton(
          page: uniquePages[i].toString(),
          isActive: uniquePages[i] == currentPage,
          onTap: () => onPageChanged(uniquePages[i]),
        ),
      );
    }

    return widgets;
  }
}

class _PageButton extends StatelessWidget {
  final String page;
  final bool isActive;
  final VoidCallback onTap;

  const _PageButton({
    required this.page,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Center(
            child: Text(
              page,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
