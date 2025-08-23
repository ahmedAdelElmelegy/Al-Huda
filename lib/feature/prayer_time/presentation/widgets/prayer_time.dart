import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerTime extends StatelessWidget {
  const PrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PrayerCubit>();

    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('remaining_time'.tr(), style: TextSTyle.f12CairoRegGrey),
                verticalSpace(4),
                Text(
                  '${'for_prayer'.tr()} ${cubit.getCurrentPrayer().tr()}',
                  style: TextSTyle.f14CairoBoldPrimary.copyWith(
                    color: ColorManager.primaryText,
                  ),
                ),
              ],
            ),
            horizontalSpace(16),
            StreamBuilder<int>(
              stream: Stream.periodic(const Duration(seconds: 1), (x) => x),
              builder: (context, snapshot) {
                return Text(
                  PrayerServices.getRemainingTime(cubit),
                  style: TextSTyle.f20CairoLightGrey,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
