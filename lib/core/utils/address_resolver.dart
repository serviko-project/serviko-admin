import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addressResolverProvider =
    FutureProvider.family<String, ({double lat, double lon})>((
      ref,
      coords,
    ) async {
      final lat = coords.lat;
      final lon = coords.lon;

      try {
        final dio = Dio();
        final response = await dio.get(
          'https://nominatim.openstreetmap.org/reverse',
          queryParameters: {'format': 'jsonv2', 'lat': lat, 'lon': lon},
        );

        if (response.statusCode == 200 && response.data != null) {
          final address = response.data['address'] as Map<String, dynamic>?;
          if (address != null) {
            final placeName =
                address['amenity'] ??
                address['building'] ??
                address['shop'] ??
                address['office'] ??
                address['leisure'];
            final road =
                address['road'] ?? address['pedestrian'] ?? address['street'];
            final suburb = address['suburb'] ?? address['neighbourhood'];
            final city =
                address['city'] ?? address['town'] ?? address['village'];
            final district =
                address['state_district'] ??
                address['county'] ??
                address['district'];
            final state = address['state'];

            final parts = <String>[];

            if (placeName != null) {
              parts.add(placeName.toString());
            } else if (address['house_number'] != null && road != null) {
              parts.add('${address['house_number']} $road');
            } else if (road != null) {
              parts.add(road.toString());
            }

            if (suburb != null) {
              parts.add(suburb.toString());
            } else if (city != null) {
              parts.add(city.toString());
            }

            if (district != null) {
              parts.add(district.toString());
            }

            if (state != null) {
              parts.add(state.toString());
            }

            if (parts.isNotEmpty) {
              return parts.toSet().join(', ');
            }
          }
        }

        return 'Unknown Location';
      } catch (e) {
        return 'Unable to resolve address';
      }
    });
