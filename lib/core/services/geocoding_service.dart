import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
  final String apiKey;

  GeocodingService({required this.apiKey});

  Future<Map<String, String?>> getAddressFromCoordinates(
      double lat, double lng) async {
    final uri = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json'
      '?latlng=$lat,$lng&key=$apiKey',
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch address');
    }

    final data = jsonDecode(response.body);
    if (data['status'] != 'OK' || data['results'].isEmpty) {
      return {'city': null, 'state': null, 'pincode': null};
    }

    final components = data['results'][0]['address_components'] as List;
    String? city;
    String? state;
    String? pincode;

    for (final c in components) {
      final types = List<String>.from(c['types']);
      if (types.contains('locality')) {
        city = c['long_name'];
      } else if (types.contains('administrative_area_level_1')) {
        state = c['long_name'];
      } else if (types.contains('postal_code')) {
        pincode = c['long_name'];
      }
    }

    return {
      'city': city,
      'state': state,
      'pincode': pincode,
    };
  }
}
