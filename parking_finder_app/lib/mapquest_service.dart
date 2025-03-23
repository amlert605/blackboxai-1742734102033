import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import '../utils/map_utils.dart';

class MapQuestService {
  static Future<String> reverseGeocode(LatLng location) async {
    final url = MapUtils.getReverseGeocodingUrl(location);
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final location = data['results'][0]['locations'][0];
        return '${location['street']}, ${location['adminArea5']}, ${location['adminArea3']}';
      }
      return 'Address not found';
    } catch (e) {
      print('Error in reverse geocoding: $e');
      return 'Error getting address';
    }
  }

  static Future<LatLng?> searchLocation(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url = 'https://www.mapquestapi.com/geocoding/v1/address'
        '?key=${MapUtils.mapQuestApiKey}'
        '&location=$encodedQuery';

    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final location = data['results'][0]['locations'][0]['latLng'];
        return LatLng(location['lat'], location['lng']);
      }
      return null;
    } catch (e) {
      print('Error in location search: $e');
      return null;
    }
  }

  static String getStaticMapUrl(LatLng location, {int zoom = 15}) {
    return MapUtils.getStaticMapUrl(location, zoom);
  }

  static String getDirectionsUrl(LatLng start, LatLng end) {
    return 'https://www.mapquestapi.com/directions/v2/route'
        '?key=${MapUtils.mapQuestApiKey}'
        '&from=${start.latitude},${start.longitude}'
        '&to=${end.latitude},${end.longitude}';
  }
}
