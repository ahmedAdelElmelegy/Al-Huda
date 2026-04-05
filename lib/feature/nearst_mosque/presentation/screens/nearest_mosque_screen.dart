import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/utils/constants.dart';
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
  bool get isArabic => context.locale.languageCode == 'ar';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<GoogleMapCubit, GoogleMapState>(
      builder: (context, state) {
        final bloc = context.read<GoogleMapCubit>();
        final currentLocation = bloc.currentLocation;

        if (state is GetCurrentLocationLoaded) {
          return const Center(
            child: CircularProgressIndicator(color: ColorManager.primary),
          );
        }

        return Scaffold(
          backgroundColor: isDark
              ? ColorManager.backgroundDark
              : ColorManager.background,
          appBar: AppBar(
            title: Text(
              'nearest_mosque'.tr(),
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: ColorManager.primary,
            elevation: 4,
            shadowColor: ColorManager.primary.withValues(alpha: 0.2),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16.r),
              ),
            ),
          ),
          body: SafeArea(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: FlutterMap(
                mapController: bloc.mapController,
                options: MapOptions(
                  initialCenter: LatLng(
                    currentLocation?.latitude ?? 24.7136,
                    currentLocation?.longitude ?? 46.6753,
                  ),
                  onTap: (tapPosition, latLng) {
                    bloc.addDestinationMarker(latLng);
                    _showLocationDetails(context, bloc);
                  },
                  initialZoom: 14,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.uber',
                  ),
                  MarkerLayer(markers: bloc.markers),
                  if (bloc.routeCoordinates.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: bloc.routeCoordinates,
                          color: ColorManager.primary,
                          strokeWidth: 5,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMapActionButton(
                  icon: Icons.my_location_rounded,
                  onPressed: () {
                    bloc.followUser = true;
                    bloc.getCurrentLocation();
                    SharedPrefServices.setValue(
                      bloc.currentLocation?.latitude.toString() ?? "",
                      Constants.lat,
                    );
                    SharedPrefServices.setValue(
                      bloc.currentLocation?.longitude.toString() ?? "",
                      Constants.lng,
                    );
                    context.read<PrayerCubit>().getPrayerTimes();
                  },
                  heroTag: "location",
                  color: ColorManager.primary,
                ),
                verticalSpace(16),
                _buildMapActionButton(
                  icon: Icons.mosque_rounded,
                  onPressed: () async {
                    if (bloc.currentLocation != null) {
                      final mosque = await bloc.getNearestMosque(
                        bloc.currentLocation!.latitude!,
                        bloc.currentLocation!.longitude!,
                      );
                      if (mosque != null) {
                        if (!context.mounted) return;
                        _showMosqueFound(context, mosque);
                      } else {
                        if (!context.mounted) return;
                        _showNoMosque(context);
                      }
                    }
                  },
                  heroTag: "mosque",
                  color: const Color(0xFF009688),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: isArabic
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  Widget _buildMapActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String heroTag,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(icon, color: Colors.white, size: 24.sp),
      ),
    );
  }

  void _showLocationDetails(BuildContext context, GoogleMapCubit bloc) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? ColorManager.surfaceDark : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "تفاصيل الموقع",
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 20.sp,
                color: ColorManager.primary,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(24),
            _buildDetailRow(
              "المدينة",
              bloc.cityName,
              Icons.location_city_rounded,
            ),
            verticalSpace(12),
            _buildDetailRow("الدولة", bloc.countryName, Icons.public_rounded),
            verticalSpace(32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Text(
                "حسناً",
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: ColorManager.primary, size: 20.sp),
        horizontalSpace(12),
        Text(
          "$label:",
          style: TextStyle(
            fontFamily: 'SSTArabicRoman',
            fontSize: 14.sp,
            color: ColorManager.textLight,
          ),
        ),
        horizontalSpace(8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'SSTArabicMedium',
              fontSize: 14.sp,
              color: ColorManager.textHigh,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  void _showMosqueFound(BuildContext context, LatLng mosque) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "تم العثور على مسجد بالقرب منك",
          style: TextStyle(fontFamily: 'SSTArabicRoman', fontSize: 14.sp),
        ),
        backgroundColor: ColorManager.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  void _showNoMosque(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "لم يتم العثور على مساجد قريبة",
          style: TextStyle(fontFamily: 'SSTArabicRoman', fontSize: 14.sp),
        ),
        backgroundColor: Colors.red[400],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
