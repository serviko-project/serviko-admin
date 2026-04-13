import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import '../widgets/categories_filter_bar.dart';
import '../widgets/categories_grid.dart';
import '../widgets/categories_stats_header.dart';

// Categories Screen
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // Top Stats Cards (Total, Active, Inactive)
            CategoriesStatsHeader(),
            SizedBox(height: 24),

            // Categories Filter Bar
            CategoriesFilterBar(),
            SizedBox(height: 24),

            // Categories Grid
            CategoriesGrid(),
          ],
        ),
      ),
    );
  }
}
