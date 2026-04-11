import 'package:flutter/material.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';
import 'components/request_card.dart';

// Category Requests List Widget
class CategoryRequestsList extends StatelessWidget {
  const CategoryRequestsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Category Requests',
                style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '3 PENDING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.lg),

          // List of Request Cards
          LayoutBuilder(
            builder: (context, constraints) {
              const cards = [
                RequestCard(
                  title: 'Smart Home Installation',
                  requester: 'TechNova Inc.',
                  date: 'Oct 24, 2025',
                ),
                RequestCard(
                  title: 'Eco-Friendly Cleaning',
                  requester: 'GreenWay Pros',
                  date: 'Oct 23, 2025',
                ),
                RequestCard(
                  title: 'Pet Grooming (Mobile)',
                  requester: 'Bark & Bubbles',
                  date: 'Oct 22, 2025',
                ),
              ];

              // Two-column layout for wider screens
              if (constraints.maxWidth >= 600) {
                final cardWidth = ((constraints.maxWidth - AppSizes.md) / 2)
                    .floorToDouble();
                return Wrap(
                  spacing: AppSizes.md,
                  runSpacing: AppSizes.md,
                  children: cards
                      .map((card) => SizedBox(width: cardWidth, child: card))
                      .toList(),
                );
              }

              // Normal single column layout
              return Column(
                children: [
                  cards[0],
                  const SizedBox(height: AppSizes.md),
                  cards[1],
                  const SizedBox(height: AppSizes.md),
                  cards[2],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
