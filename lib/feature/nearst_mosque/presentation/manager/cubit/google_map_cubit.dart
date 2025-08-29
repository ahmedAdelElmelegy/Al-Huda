import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

part 'google_map_state.dart';

class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit() : super(GoogleMapInitial());

  LocationData? currentLocation;
  List<Marker> markers = [];
  List<LatLng> routeCoordinates = [];
  bool followUser = true;

  MapController mapController = MapController();
  TextEditingController searchController = TextEditingController();

  // Get current location and listen for updates
  Future<void> getCurrentLocation() async {
    emit(GetCurrentLocationLoading());
    var location = Location();

    try {
      var userLocation = await location.getLocation();
      _updateLocation(userLocation);

      location.onLocationChanged.listen((newLocation) {
        _updateLocation(newLocation);
      });
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  void _updateLocation(LocationData locationData) {
    currentLocation = locationData;

    // Remove only the old blue location marker, keep others
    markers.removeWhere(
      (m) => m.child is Icon && (m.child as Icon).color == Colors.blue,
    );

    markers.add(
      Marker(
        width: 80,
        height: 80,
        point: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
        child: const Icon(Icons.my_location, color: Colors.blue, size: 40),
      ),
    );

    // Move map only if following user
    if (followUser) {
      mapController.move(
        LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
        14,
      );
    }
    emit(UpdateCurrentLocation());
  }

  // Get route to destination
  Future<void> getRoute(LatLng destination) async {
    emit(GetRouteLoading());
    if (currentLocation == null) return;

    final start = LatLng(
      currentLocation!.latitude!,
      currentLocation!.longitude!,
    );

    const apiKey =
        "5b3ce3597851110001cf62480153e35485a746dcb6d405beb6c1dadc"; // openrouteservice.org API key

    final url =
        'https://api.openrouteservice.org/v2/directions/driving-car'
        '?api_key=$apiKey'
        '&start=${start.longitude},${start.latitude}'
        '&end=${destination.longitude},${destination.latitude}'
        '&geometry_format=geojson';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> coords =
          data['features'][0]['geometry']['coordinates'];

      if (coords.isNotEmpty) {
        routeCoordinates = coords.map((e) => LatLng(e[1], e[0])).toList();

        // Remove old red destination marker if any
        markers.removeWhere(
          (m) => m.child is Icon && (m.child as Icon).color == Colors.red,
        );

        markers.add(
          Marker(
            width: 80,
            height: 80,
            point: destination,
            child: const Icon(Icons.location_on, color: Colors.red, size: 40),
          ),
        );

        followUser = false;
        emit(GetRouteSuccess());
      }
    } else {
      debugPrint("Route API error: ${response.statusCode}");
    }
  }

  // Add a destination marker and get route
  void addDestinationMarker(LatLng destination) {
    emit(GetRouteLoading());

    markers.add(
      Marker(
        width: 80,
        height: 80,
        point: destination,
        child: const Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
    );
    followUser = false;
    emit(GetRouteSuccess());
    getRoute(destination);
  }

  // Search for a place
  Future<void> searchPlace(
    String query,
    void Function(LatLng) onLocationUpdate,
  ) async {
    if (query.isEmpty) return;
    emit(SearchPlaceLoading());

    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1';
    final response = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': 'flutter_map_example'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);
        final position = LatLng(lat, lon);

        onLocationUpdate(position);
        followUser = false;

        // Remove old green search markers
        markers.removeWhere(
          (m) => m.child is Icon && (m.child as Icon).color == Colors.green,
        );

        markers.add(
          Marker(
            width: 80,
            height: 80,
            point: position,
            child: const Icon(Icons.location_on, color: Colors.green, size: 40),
          ),
        );

        // Move to searched location
        mapController.move(position, 14);

        // Optionally get a route from current location to searched place
        if (currentLocation != null) {
          await getRoute(position);
        }

        emit(SearchPlaceSuccess());
      }
    } else {
      debugPrint('Search failed: ${response.statusCode}');
      emit(SearchPlaceFailure());
    }
  }

  String cityName = '';
  String countryName = '';

  // Reverse geocoding to get city and country
  Future<void> getCityNameAndCountryName(LatLng position) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?lat=${position.latitude}&lon=${position.longitude}&format=json';
    final response = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': 'flutter_map_example'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final address = data['address'];

      final city =
          address['city'] ??
          address['town'] ??
          address['village'] ??
          address['municipality'] ??
          '';

      final country = address['country'] ?? '';

      debugPrint('City: $city');
      debugPrint('Country: $country');

      cityName = city;
      countryName = country;
      emit(GetCityNameAndCountryNameSuccess());
    } else {
      debugPrint('Reverse geocoding failed: ${response.statusCode}');
    }
  }

  /// Get nearest mosque using Overpass API (OpenStreetMap)
  Future<LatLng?> getNearestMosque(double lat, double lng) async {
    emit(GetRouteLoading());

    // Overpass query: mosques around location
    final query =
        """
    [out:json][timeout:25];
    (
      node["amenity"="place_of_worship"]["religion"="muslim"](around:5000,$lat,$lng);
      node["building"="mosque"](around:5000,$lat,$lng);
    );
    out center;
  """;

    final url = Uri.parse("https://overpass-api.de/api/interpreter");
    final response = await http.post(url, body: {"data": query});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["elements"].isNotEmpty) {
        final place = data["elements"][0];
        final mosquePosition = LatLng(place["lat"], place["lon"]);

        // Remove old mosque markers
        markers.removeWhere(
          (m) => m.child is Icon && (m.child as Icon).color == Colors.purple,
        );

        // Add new mosque marker
        markers.add(
          Marker(
            width: 80,
            height: 80,
            point: mosquePosition,
            child: const Icon(Icons.mosque, color: Colors.purple, size: 40),
          ),
        );

        // Get route to mosque
        if (currentLocation != null) {
          await getRoute(mosquePosition);
        }

        emit(GetRouteSuccess());
        return mosquePosition;
      } else {
        debugPrint("No mosques found nearby");
      }
    } else {
      debugPrint("Overpass API error: ${response.statusCode}");
    }
    return null;
  }
}
