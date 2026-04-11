import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';
import 'action_cell.dart';
import 'provider_cell.dart';
import 'status_badge.dart';

// Recent Applications Table Widget
class RecentApplicationsTable extends StatelessWidget {
  const RecentApplicationsTable({super.key});

  @override
  Widget build(BuildContext context) {
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
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
          const SizedBox(height: AppSizes.lg),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(4),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1.0),
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      top: 16.0,
                      bottom: 16.0,
                    ),
                    child: Text(
                      'PROVIDER',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        'SERVICE TYPE',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        'STATUS',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        'ACTION',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // sample Data
              _buildTableRow(
                name: 'User 1',
                email: 'user1@example.com',
                initials: 'AA',
                service: 'Plumbing Services',
                status: 'PENDING',
              ),
              _buildTableRow(
                name: 'User 2',
                email: 'user2@example.com',
                initials: 'SK',
                service: 'Interior Design',
                status: 'APPROVED',
              ),
              _buildTableRow(
                name: 'User 3',
                email: 'user3@example.com',
                initials: 'RM',
                service: 'Electrician',
                status: 'PENDING',
              ),
              _buildTableRow(
                name: 'User 4',
                email: 'user4@example.com',
                initials: 'JD',
                service: 'Plumber',
                status: 'BLOCKED',
              ),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow({
    required String name,
    required String email,
    required String initials,
    required String service,
    required String status,
  }) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFF3F4F6), width: 0.5),
        ),
      ),
      children: [
        // Provider Cell
        Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 12.0, bottom: 12.0),
          child: ProviderCell(name: name, email: email, initials: initials),
        ),

        // Service Name
        Center(child: Text(service, style: const TextStyle(fontSize: 12))),

        // Status Badge
        Center(child: StatusBadge(status: status)),

        // Action Cell
        const Center(child: ActionCell()),
      ],
    );
  }
}
