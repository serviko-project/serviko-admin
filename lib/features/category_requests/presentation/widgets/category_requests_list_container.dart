import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/network/pagination_meta.dart';
import '../../domain/entities/category_request_entity.dart';
import 'category_request_table_header.dart';
import 'category_request_table_row.dart';
import '../../../providers/presentation/widgets/providers_pagination_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/category_request_provider.dart';

class CategoryRequestsListContainer extends StatelessWidget {
  final bool isLoading;
  final WidgetRef ref;
  final List<CategoryRequestEntity> requests;
  final PaginationMeta? meta;

  const CategoryRequestsListContainer({
    super.key,
    required this.requests,
    this.meta,
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
                        1: FlexColumnWidth(2.5), // Provider
                        2: FlexColumnWidth(2.5), // Category
                        3: FlexColumnWidth(3), // Description
                        4: FlexColumnWidth(1.5), // Submitted
                        5: FlexColumnWidth(1.5), // Status
                        6: FlexColumnWidth(1), // Actions
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        // Table Header
                        buildCategoryRequestTableHeader(),

                        // Table Rows
                        if (!isLoading && requests.isNotEmpty)
                          ...requests.map(
                            (r) =>
                                buildCategoryRequestTableRow(r, ref, context),
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
              padding: const EdgeInsets.all(2 * AppSizes.xl),
              child: Center(
                child: Text(
                  'No requests found..!!',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),

          // Pagination Bar
          if (meta != null)
            ProvidersPaginationBar(
              totalItems: meta!.total,
              currentPage: meta!.page,
              itemsPerPage: meta!.limit,
              onPageChanged: (page) {
                ref.read(categoryRequestPageProvider.notifier).setPage(page);
              },
            ),
        ],
      ),
    );
  }
}
