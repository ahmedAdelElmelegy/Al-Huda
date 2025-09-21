import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/location_services.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/nearst_mosque/presentation/manager/cubit/google_map_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDateAndLocation extends StatefulWidget {
  final bool isPrayerTime;
  final String? location;
  const HomeDateAndLocation({
    super.key,
    this.isPrayerTime = false,
    this.location,
  });

  @override
  State<HomeDateAndLocation> createState() => _HomeDateAndLocationState();
}

class _HomeDateAndLocationState extends State<HomeDateAndLocation> {
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
    final date = DateTime.now();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // التاريخ
          SizedBox(
            width: 150.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    PrayerServices.getFormattedGregorianDate(date, context),
                    style: TextSTyle.f12CairoRegGrey,
                  ),
                ),
                verticalSpace(4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    PrayerServices.getFormattedHijriDate(date, context),
                    style: widget.isPrayerTime
                        ? TextSTyle.f16CairoMediumBlack.copyWith(
                            color: ColorManager.primaryText,
                          )
                        : TextSTyle.f16SSTArabicRegBlack,
                  ),
                ),
              ],
            ),
          ),
          // المكان
          SizedBox(
            width: 120.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('place'.tr(), style: TextSTyle.f12CairoRegGrey),
                verticalSpace(4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _isLoading ? "..." : _cityName ?? 'location'.tr(),
                    style: widget.isPrayerTime
                        ? TextSTyle.f16CairoMediumBlack.copyWith(
                            color: ColorManager.primaryText,
                          )
                        : TextSTyle.f14SSTArabicMediumPrimary.copyWith(
                            color: ColorManager.primaryText2,
                          ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
