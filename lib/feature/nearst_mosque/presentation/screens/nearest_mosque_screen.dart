import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/nearst_mosque/presentation/manager/cubit/google_map_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class NearestMosqueScreen extends StatefulWidget {
  const NearestMosqueScreen({super.key});

  @override
  State<NearestMosqueScreen> createState() => _NearestMosqueScreenState();
}

class _NearestMosqueScreenState extends State<NearestMosqueScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapCubit, GoogleMapState>(
      builder: (context, state) {
        final bloc = context.read<GoogleMapCubit>();
        final currentLocation = bloc.currentLocation;
        if (state is GetCurrentLocationLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: CustomAppBarWithArrow(
            title: 'nearest_mosque'.tr(),
            icon: AppIcons.mosque,
          ),
          body: SafeArea(
            child: FlutterMap(
              mapController: bloc.mapController,
              options: MapOptions(
                initialCenter: LatLng(
                  currentLocation?.latitude ?? 24.7136,
                  currentLocation?.longitude ?? 46.6753,
                ),
                onTap: (tapPosition, latLng) {
                  bloc.addDestinationMarker(latLng);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Destination'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('City: ${bloc.cityName}'),
                            Text('Country: ${bloc.countryName}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                initialZoom: 14,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.uber',
                ),
                MarkerLayer(markers: bloc.markers),

                if (bloc.routeCoordinates.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: bloc.routeCoordinates,
                        color: Colors.red,
                        strokeWidth: 4,
                      ),
                    ],
                  ),
              ],
            ),
          ),

          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: "location",
                onPressed: () {
                  bloc.followUser = true; // re-enable GPS follow
                  bloc.getCurrentLocation();
                  SharedPrefServices.setValue(
                    bloc.currentLocation?.latitude.toString() ?? "",
                    Constants.lat,
                  );
                  SharedPrefServices.setValue(
                    bloc.currentLocation?.longitude.toString() ?? "",
                    Constants.lng,
                  );
                  if (bloc.currentLocation != null) {
                    // bloc.getCityNameAndCountryName(
                    //   LatLng(
                    //     bloc.currentLocation?.latitude ?? 0,
                    //     bloc.currentLocation?.longitude ?? 0,
                    //   ),
                    // );
                  }
                  context.read<PrayerCubit>().getPrayerTimes();
                },
                child: const Icon(Icons.my_location),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: "mosque",
                backgroundColor: Colors.purple,
                onPressed: () async {
                  if (bloc.currentLocation != null) {
                    final mosque = await bloc.getNearestMosque(
                      bloc.currentLocation!.latitude!,
                      bloc.currentLocation!.longitude!,
                    );

                    // ignore: use_build_context_synchronously

                    if (mosque != null) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Nearest mosque at ${mosque.latitude}, ${mosque.longitude}",
                          ),
                        ),
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No mosque found nearby")),
                      );
                    }
                  }
                },
                child: const Icon(Icons.mosque, color: Colors.white),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        );
      },
    );
  }
}
