import 'package:latlong2/latlong.dart';

class MapUtils {
  static const String mapQuestApiKey = 'gdAUsDdppCIuVMM7LJSRE4e4Ujav96jU';
  
  // Default map center (can be adjusted based on your needs)
  static const LatLng defaultCenter = LatLng(14.5995, 120.9842); // Manila coordinates
  
  // Map configuration
  static const double defaultZoom = 15.0;
  static const double minZoom = 3.0;
  static const double maxZoom = 18.0;
  
  // Marker sizes
  static const double markerWidth = 80.0;
  static const double markerHeight = 80.0;
  static const double markerIconSize = 40.0;

  // MapQuest URL templates
  static String getStaticMapUrl(LatLng location, int zoom) {
    return 'https://www.mapquestapi.com/staticmap/v5/map'
        '?key=$mapQuestApiKey'
        '&center=${location.latitude},${location.longitude}'
        '&zoom=$zoom'
        '&size=600,400';
  }

  static String getReverseGeocodingUrl(LatLng location) {
    return 'https://www.mapquestapi.com/geocoding/v1/reverse'
        '?key=$mapQuestApiKey'
        '&location=${location.latitude},${location.longitude}';
  }
}
