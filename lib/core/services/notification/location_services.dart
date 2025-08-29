import 'package:al_huda/core/services/qran_services.dart';
import 'package:location/location.dart';

class LocationService {
  final Location location = Location();

  Future<Coordinates> getCoordinates() async {
    // حاول تجيب القيم من SharedPreferences
    String? lat = await SharedPrefServices.getValue("lat");
    String? lng = await SharedPrefServices.getValue("lng");

    if (lat != null && lng != null) {
      return Coordinates(double.parse(lat), double.parse(lng));
    }

    // لو مش موجودة هات من الجهاز نفسه
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception("Location service not enabled");
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception("Location permission not granted");
      }
    }

    final LocationData locationData = await location.getLocation();

    // خزّن القيم علشان المرة الجاية نستخدمها
    await SharedPrefServices.setValue("lat", locationData.latitude.toString());
    await SharedPrefServices.setValue("lng", locationData.longitude.toString());

    return Coordinates(locationData.latitude!, locationData.longitude!);
  }
}

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates(this.latitude, this.longitude);
}
