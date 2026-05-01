import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../providers/domain/entities/provider_entity.dart';
import 'provider_details_card.dart';
import 'provider_section_title.dart';

class ProviderDocumentsCard extends StatelessWidget {
  final ProviderEntity provider;

  const ProviderDocumentsCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    if (provider.documents.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProviderSectionTitle('Submitted Documents'),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: provider.documents
              .map(
                (doc) => SizedBox(
                  width: 350,
                  child: ProviderDetailsCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.description,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _formatDocType(doc.documentType),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              if (doc.originalFilename != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  doc.originalFilename!,
                                  style: const TextStyle(
                                    color: AppColors.textHint,
                                    fontSize: 11,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () async {
                                  final uri = Uri.parse(doc.fileUrl);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(
                                      uri,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.open_in_new,
                                      color: AppColors.primary,
                                      size: 13,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'View Document',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // Converts snake_case doc type to Title Case
  String _formatDocType(String type) {
    return type
        .split('_')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}
