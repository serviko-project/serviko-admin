import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../providers/providers_provider.dart';
import '../widgets/provider_details/provider_profile_card.dart';
import '../widgets/provider_details/provider_description_card.dart';
import '../widgets/provider_details/provider_documents_card.dart';
import '../widgets/provider_details/provider_categories_card.dart';
import '../widgets/provider_details/provider_map_card.dart';
import '../widgets/provider_details/provider_quick_actions_card.dart';
import '../widgets/provider_details/provider_availability_card.dart';
import '../widgets/provider_details/provider_application_history_card.dart';

//  Provider Details Screen
class ProviderDetailsScreen extends ConsumerWidget {
  const ProviderDetailsScreen({super.key, required this.providerId});

  final String providerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerState = ref.watch(providerDetailsProvider(providerId));
    final review = providerReviewActionProvider(providerId);

    // Listen for action completion to show notifications
    ref.listen(review, (previous, next) {
      next.whenOrNull(
        data: (action) {
          if (previous is AsyncLoading && action != null) {
            String message;
            switch (action) {
              case 'approve':
                message = 'Provider approved successfully';
                break;
              case 'reject':
                message = 'Provider rejected successfully';
                break;
              case 'block':
                message = 'Provider blocked successfully';
                break;
              default:
                message = 'Action performed successfully';
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: AppColors.success,
              ),
            );
          }
        },
        error: (err, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Action failed: $err'),
              backgroundColor: AppColors.error,
            ),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.textPrimary,
            size: AppSizes.iconSm,
          ),
          onPressed: () => context.goNamed('providers'),
        ),
        title: const Text(
          'Provider Details',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: providerState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (provider) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth >= 900;

                final leftColumn = Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 35,
                  children: [
                    ProviderProfileCard(provider: provider),
                    ProviderDescriptionCard(provider: provider),
                    ProviderDocumentsCard(provider: provider),
                    ProviderCategoriesCard(provider: provider),
                    ProviderMapCard(provider: provider),
                  ],
                );

                final rightColumn = Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 25,
                  children: [
                    ProviderQuickActionsCard(
                      provider: provider,
                      loadingAction: ref.watch(review).isLoading
                          ? ref.read(review.notifier).activeAction
                          : null,
                      onReviewAction: (action, {rejectionReason}) {
                        final notifier = ref.read(
                          providerReviewActionProvider(providerId).notifier,
                        );
                        notifier.reviewProvider(
                          action: action,
                          rejectionReason: rejectionReason,
                        );
                      },
                    ),
                    ProviderAvailabilityCard(provider: provider),
                    ProviderApplicationHistoryCard(provider: provider),
                  ],
                );

                if (isDesktop) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 7, child: leftColumn),
                      const SizedBox(width: 24),
                      Expanded(flex: 3, child: rightColumn),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    leftColumn,
                    const SizedBox(height: 24),
                    rightColumn,
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
