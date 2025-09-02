import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;

class LocationService {
  static final loc.Location _location = loc.Location();

  /// 1. Check permission and return Lat & Lng
  static Future<loc.LocationData?> checkPermissionAndGetLocation() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    // Check if location service is enabled
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check permission
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return null;
      }
    }

    // Get location
    return await _location.getLocation();
  }

  /// 2. Get address from Lat & Lng
  static Future<String?> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        lat,
        lng,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final city = place.locality ?? "";
        // final country = place.country ?? "";
        return city;
      } else {
        return "Unknown location";
      }
    } catch (e) {
      return null;
    }
  }

  /// 3. Get City Name directly
  static Future<String?> getCityName() async {
    final locationData = await checkPermissionAndGetLocation();
    if (locationData != null) {
      return await getAddressFromLatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
    }
    return null;
  }
}
