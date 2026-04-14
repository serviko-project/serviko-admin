import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/entities/category_request_entity.dart';
import 'category_request_table_header.dart';
import 'category_request_table_row.dart';
import '../../../providers/presentation/widgets/providers_pagination_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryRequestsListContainer extends StatelessWidget {
  final bool isLoading;
  final WidgetRef ref;
  final List<CategoryRequestEntity> requests;

  const CategoryRequestsListContainer({
    super.key,
    required this.requests,
    this.isLoading = false,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: SizedBox(
                    width: constraints.maxWidth < 1000
                        ? 1000
                        : constraints.maxWidth,
                    child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(72), // Checkbox
                        1: FlexColumnWidth(2), // Provider
                        2: FlexColumnWidth(2), // Category
                        3: FlexColumnWidth(2.5), // Description
                        4: FlexColumnWidth(1.5), // Submitted
                        5: FlexColumnWidth(1.5), // Status
                        6: FlexColumnWidth(3), // Actions
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        // Table Header
                        buildCategoryRequestTableHeader(),

                        // Table Rows
                        if (!isLoading && requests.isNotEmpty)
                          ...requests.map(
                            (r) => buildCategoryRequestTableRow(r, ref),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // Loading State
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(AppSizes.xxl),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            )
          // Empty State
          else if (requests.isEmpty)
            Padding(
              padding: const EdgeInsets.all(AppSizes.xxl),
              child: Center(
                child: Text(
                  'No valid requests found.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),

          // Pagination Bar
          ProvidersPaginationBar(
            totalItems: 100,
            currentPage: 1,
            itemsPerPage: 10,
            onPageChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
