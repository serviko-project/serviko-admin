import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/provider_entity.dart';
import 'provider_table_header.dart';
import 'provider_table_row.dart';
import 'providers_pagination_bar.dart';

// Container for the Providers List Table
class ProvidersListContainer extends StatelessWidget {
  final List<ProviderEntity> providers;
  final bool isLoading;

  const ProvidersListContainer({
    super.key,
    required this.providers,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
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
                        0: FixedColumnWidth(72),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(1.5),
                        4: FlexColumnWidth(1),
                        5: FlexColumnWidth(1),
                        6: FlexColumnWidth(1.5),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        buildProviderTableHeader(),
                        if (!isLoading && providers.isNotEmpty)
                          ...providers.map(
                            (provider) => buildProviderTableRow(provider),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Data List or Loading state
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(48.0),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            )
          else if (providers.isEmpty)
            const Padding(
              padding: EdgeInsets.all(48.0),
              child: Center(
                child: Text(
                  'No providers found.',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ),

          // Footer Pagination Bar
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
