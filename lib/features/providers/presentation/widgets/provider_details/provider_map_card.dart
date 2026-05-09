import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:serviko_admin/features/providers/presentation/widgets/provider_details/provider_section_title.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../providers/domain/entities/provider_entity.dart';
import '../../../../../core/utils/address_resolver.dart';

class ProviderMapCard extends ConsumerWidget {
  const ProviderMapCard({super.key, required this.provider});

  final ProviderEntity provider;

  double _zoomForRadius(double radiusKm) {
    if (radiusKm <= 2) return 14.0;
    if (radiusKm <= 5) return 12.5;
    if (radiusKm <= 10) return 11.5;
    if (radiusKm <= 20) return 10.5;
    if (radiusKm <= 35) return 9.5;
    return 8.5;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Hide if no location data
    if (provider.latitude == null || provider.longitude == null) {
      return const SizedBox.shrink();
    }

    final latLng = LatLng(provider.latitude!, provider.longitude!);
    final radius = provider.coverageRadiusKm ?? 15.0;

    final radiusText = provider.coverageRadiusKm != null
        ? '${provider.coverageRadiusKm!.toStringAsFixed(0)} km radius'
        : 'Coverage area not set';

    final addressAsync = ref.watch(
      addressResolverProvider((
        lat: provider.latitude!,
        lon: provider.longitude!,
      )),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: ProviderSectionTitle("Service Area"),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.textSecondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: latLng,
                    initialZoom: _zoomForRadius(radius),
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.serviko.serviko_admin',
                    ),
                    if (provider.coverageRadiusKm != null)
                      CircleLayer(
                        circles: [
                          CircleMarker(
                            point: latLng,
                            radius: radius * 1000,
                            useRadiusInMeter: true,
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderColor: AppColors.primary.withValues(
                              alpha: 0.5,
                            ),
                            borderStrokeWidth: 2,
                          ),
                        ],
                      ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: latLng,
                          width: 40,
                          height: 40,
                          alignment: Alignment.topCenter,
                          child: const Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.primary),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addressAsync.when(
                              data: (address) => Text(
                                address,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              loading: () => const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              error: (_, _) => Text(
                                '${provider.latitude!.toStringAsFixed(4)}, ${provider.longitude!.toStringAsFixed(4)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              radiusText,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
