import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';
import 'package:serviko_admin/features/dashboard/presentation/widgets/components/table_header_row.dart';
import 'package:serviko_admin/features/dashboard/presentation/widgets/components/table_row.dart';
import 'package:serviko_admin/features/providers/presentation/providers/providers_provider.dart';

// Recent Applications Table Widget
class RecentApplicationsTable extends ConsumerWidget {
  const RecentApplicationsTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentProvidersAsync = ref.watch(recentProvidersProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.xl),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Provider Applications',
                style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => context.go('/providers'),
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.lg),
          recentProvidersAsync.when(
            data: (providers) {
              if (providers.isEmpty) {
                return Column(
                  children: [
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(4),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(2),
                      },
                      children: [buildHeaderRow()],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(AppSizes.xl * 2),
                      child: Center(
                        child: Text(
                          'No recent applications',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Table(
                columnWidths: const {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  buildHeaderRow(),
                  ...providers.map((provider) {
                    return buildTableRow(
                      context: context,
                      id: provider.id,
                      name: provider.userName,
                      email: provider.email ?? 'No email',
                      initials: provider.userName.isNotEmpty
                          ? provider.userName.substring(0, 1).toUpperCase()
                          : '?',
                      profileImageUrl: provider.profileImageUrl,
                      title: provider.professionalTitle?.isNotEmpty == true
                          ? provider.professionalTitle!
                          : 'N/A',
                      status: provider.status,
                    );
                  }),
                ],
              );
            },
            loading: () => Column(
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(4),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                  },
                  children: [buildHeaderRow()],
                ),
                const Padding(
                  padding: EdgeInsets.all(AppSizes.xl * 2),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
            error: (error, _) => Column(
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(4),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                  },
                  children: [buildHeaderRow()],
                ),
                const Padding(
                  padding: EdgeInsets.all(AppSizes.xl),
                  child: Center(
                    child: Text(
                      'Error loading providers',
                      style: TextStyle(color: AppColors.error),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
