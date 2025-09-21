import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/location_services.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/nearst_mosque/presentation/manager/cubit/google_map_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeLocation extends StatefulWidget {
  const HomeLocation({super.key});

  @override
  State<HomeLocation> createState() => _HomeLocationState();
}

class _HomeLocationState extends State<HomeLocation> {
  String? _cityName;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<GoogleMapCubit>();

    cubit.getCurrentLocation().then((_) {
      LocationService.checkPermissionAndGetLocation().then((locationData) {
        if (locationData != null) {
          SharedPrefServices.setValue('lat', locationData.latitude!.toString());
          SharedPrefServices.setValue(
            'lng',
            locationData.longitude!.toString(),
          );
        }
      });

      LocationService.getCityName().then((cityName) {
        if (cityName != null) {
          SharedPrefServices.setValue('city', cityName);

          if (mounted) {
            setState(() {
              _cityName = cityName;
              _isLoading = false;
            });
          }
        }
      });

      if (mounted) {
        context.read<PrayerCubit>().getPrayerTimes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 16.sp,
          color: ColorManager.white,
        ),
        horizontalSpace(8),
        Text(
          _isLoading ? "..." : _cityName ?? 'location'.tr(),
          style: TextSTyle.f16AmiriBoldPrimary.copyWith(
            color: ColorManager.white,
          ),
        ),
      ],
    );
  }
}
