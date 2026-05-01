import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serviko_admin/features/providers/presentation/widgets/provider_error_widget.dart';
import '../providers/providers_provider.dart';
import '../widgets/providers_header.dart';
import '../widgets/providers_list_container.dart';
import '../widgets/providers_tab_bar.dart';

// Providers Screen
class ProvidersScreen extends ConsumerWidget {
  const ProvidersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providersAsync = ref.watch(providersListProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
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
                const ProvidersHeader(),
                const ProvidersTabBar(),
                const SizedBox(height: 16),

                // Table Content
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: providersAsync.when(
                    data: (result) {
                      final (providers, meta) = result;
                      return ProvidersListContainer(
                        providers: providers,
                        meta: meta,
                        onPageChanged: (page) {
                          final notifier = ref.read(
                            providerPageProvider.notifier,
                          );
                          notifier.setPage(page);
                        },
                      );
                    },
                    // Loading State
                    loading: () => const ProvidersListContainer(
                      providers: [],
                      isLoading: true,
                    ),
                    // Error State
                    error: (error, stack) =>
                        ProviderErrorWidget(ref: ref, error: error.toString()),
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
