import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/home/presentation/widgets/home_prayer_time_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePrayerTimeListView extends StatelessWidget {
  const HomePrayerTimeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        final cubit = context.read<PrayerCubit>();
        return Container(
          padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorManager.primaryBg,
            borderRadius: BorderRadius.circular(8.r),
          ),
          // height: 106.h,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                Constants.prayer.length,
                (index) => HomePrayerTimeItem(
                  time: DateFormat(
                    'hh:mm',
                  ).format(cubit.prayerTimes[index].value),
                  isSelected:
                      cubit.getCurrentPrayer() == Constants.prayer[index].name,
                  prayerTime: Constants.prayer[index],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
