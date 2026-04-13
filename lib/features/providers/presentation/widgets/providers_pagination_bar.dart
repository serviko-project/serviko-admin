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
    this.itemsPerPage = 10,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate Display values
    final int startItem = ((currentPage - 1) * itemsPerPage) + 1;
    final int endItem = (startItem + itemsPerPage - 1) > totalItems
        ? totalItems
        : (startItem + itemsPerPage - 1);

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

            // Pagination Controls
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 20,
                    color: AppColors.textHint,
                  ),
                  onPressed: () {},
                  splashRadius: 20,
                ),
                // List of Page Buttons
                _PageButton(page: '1', isActive: true),
                _PageButton(page: '2'),
                _PageButton(page: '3'),

                // Ellipsis for skipped pages
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '...',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),

                // Last Page Button
                _PageButton(page: '10'),
                IconButton(
                  icon: const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: AppColors.textHint,
                  ),
                  onPressed: () {},
                  splashRadius: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  final String page;
  final bool isActive;

  const _PageButton({required this.page, this.isActive = false});

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
          onTap: () {},
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
