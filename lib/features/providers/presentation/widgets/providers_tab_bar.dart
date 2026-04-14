import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/provider_status.dart';
import '../providers/providers_provider.dart';

// Tab Bar for filtering providers by status
class ProvidersTabBar extends ConsumerWidget {
  const ProvidersTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStatus = ref.watch(providerStatusFilterProvider);
    final pendingCountAsync = ref.watch(pendingProvidersCountProvider);

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // All Providers Tab
            _TabItem(
              title: 'All Providers',
              isActive: currentStatus == null,
              onTap: () => ref
                  .read(providerStatusFilterProvider.notifier)
                  .setStatus(null),
            ),

            // Pending Approval Tab with Badge Count
            _TabItem(
              title: 'Pending Approval',
              isActive: currentStatus == ProviderStatus.pending,
              onTap: () => ref
                  .read(providerStatusFilterProvider.notifier)
                  .setStatus(ProviderStatus.pending),
              badgeCount: pendingCountAsync.maybeWhen(
                data: (count) => count,
                orElse: () => 0,
              ),
            ),

            // Active Providers Tab
            _TabItem(
              title: 'Active',
              isActive: currentStatus == ProviderStatus.active,
              onTap: () => ref
                  .read(providerStatusFilterProvider.notifier)
                  .setStatus(ProviderStatus.active),
            ),

            // Blocked Providers Tab
            _TabItem(
              title: 'Blocked',
              isActive: currentStatus == ProviderStatus.blocked,
              onTap: () => ref
                  .read(providerStatusFilterProvider.notifier)
                  .setStatus(ProviderStatus.blocked),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final int badgeCount;

  const _TabItem({
    required this.title,
    required this.isActive,
    required this.onTap,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(right: 32.0),
        padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.primary : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                color: isActive ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            if (badgeCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.warning,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    badgeCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
