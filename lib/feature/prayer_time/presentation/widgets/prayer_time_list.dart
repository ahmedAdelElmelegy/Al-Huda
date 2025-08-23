import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/prayer_time/presentation/widgets/prayer_time_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimeList extends StatelessWidget {
  const PrayerTimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.bg),
          fit: BoxFit.cover,
        ),
      ),
      child: BlocBuilder<PrayerCubit, PrayerState>(
        builder: (context, state) {
          final cubit = context.read<PrayerCubit>();

          return Column(
            children: List.generate(
              Constants.prayer.length,
              (index) => PrayerTimeItem(
                prayer: Constants.prayer[index],
                time: DateFormat(
                  'hh:mm',
                ).format(cubit.prayerTimes[index].value),
                isSelected:
                    cubit.getCurrentPrayer() == Constants.prayer[index].name,
              ),
            ),
          );
        },
      ),
    );
  }
}
