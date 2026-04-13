import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers_provider.dart';

// Providers Header Widget (Search, Filters, Export Button)
class ProvidersHeader extends ConsumerWidget {
  const ProvidersHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Row(
        children: [
          // Search Field
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                onChanged: (value) => ref
                    .read(providerSearchQueryProvider.notifier)
                    .setQuery(value),
                style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                decoration: const InputDecoration(
                  hintText: 'Search providers by name, email or services',
                  hintStyle: TextStyle(color: AppColors.textHint, fontSize: 12),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textHint,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Filter Icon
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.textSecondary),
            onPressed: () {},
          ),

          const SizedBox(width: 8),

          // Export Data Button
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.file_download_outlined, size: 18),
            label: const Text(
              'Export Data',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
