import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'components/stat_card.dart';

// Grid of Stat Cards on the Dashboard
class StatCardsGrid extends StatelessWidget {
  const StatCardsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 4;
        if (constraints.maxWidth < 600) {
          crossAxisCount = 1;
        } else if (constraints.maxWidth < 1100) {
          crossAxisCount = 2;
        }

        return GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSizes.lg,
            mainAxisSpacing: AppSizes.lg,
            mainAxisExtent: 130,
          ),
          children: const [
            // Active Providers Card
            StatCard(
              title: 'ACTIVE PROVIDERS',
              value: '342',
              badgeText: '+18 this week',
              badgeColor: Colors.green,
              icon: Icons.people,
              iconColor: Colors.blue,
            ),

            // Pending Approvals Card
            StatCard(
              title: 'PENDING APPROVALS',
              value: '7',
              badgeText: 'Needs review',
              badgeColor: Colors.orange,
              icon: Icons.verified_user,
              iconColor: Colors.orange,
            ),

            // Total Categories Card
            StatCard(
              title: 'TOTAL CATEGORIES',
              value: '24',
              badgeText: '+2 this month',
              badgeColor: Colors.green,
              icon: Icons.category,
              iconColor: Colors.purple,
            ),

            // Category Requests Card
            StatCard(
              title: 'CATEGORY REQUESTS',
              value: '3',
              badgeText: 'Awaiting action',
              badgeColor: Colors.purple,
              icon: Icons.assignment,
              iconColor: Colors.purple,
            ),
          ],
        );
      },
    );
  }
}
