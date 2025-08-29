import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/services/qran_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/nearst_mosque/presentation/manager/cubit/google_map_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

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
  @override
  void initState() {
    final cubit = context.read<GoogleMapCubit>();

    cubit.getCurrentLocation().then((_) {
      if (cubit.currentLocation != null) {
        cubit.getCityNameAndCountryName(
          LatLng(
            cubit.currentLocation!.latitude!,
            cubit.currentLocation!.longitude!,
          ),
        );
        SharedPrefServices.setValue(
          'lat',
          cubit.currentLocation!.latitude!.toString(),
        );
        SharedPrefServices.setValue(
          'lng',
          cubit.currentLocation!.longitude!.toString(),
        );
      }
      if (mounted) {
        context.read<PrayerCubit>().getPrayerTimes();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                PrayerServices.getFormattedGregorianDate(date),
                style: TextSTyle.f12CairoRegGrey,
              ),
              verticalSpace(4),
              Text(
                PrayerServices.getFormattedHijriDate(date),
                style: widget.isPrayerTime
                    ? TextSTyle.f16CairoMediumBlack.copyWith(
                        color: ColorManager.primaryText,
                      )
                    : TextSTyle.f16SSTArabicRegBlack,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('place'.tr(), style: TextSTyle.f12CairoRegGrey),
              verticalSpace(4),
              BlocBuilder<GoogleMapCubit, GoogleMapState>(
                builder: (context, state) {
                  final cubit = context.read<GoogleMapCubit>();
                  return Text(
                    cubit.cityName.isEmpty ? "..." : cubit.cityName,
                    style: widget.isPrayerTime
                        ? TextSTyle.f16CairoMediumBlack.copyWith(
                            color: ColorManager.primaryText,
                          )
                        : TextSTyle.f16SSTArabicRegBlack,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
