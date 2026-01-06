import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/prayer_traker_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce/hive.dart';

class PrayerTimeList extends StatelessWidget {
  final List<bool> completedPrayers;
  final Function(int index) onChanged;

  const PrayerTimeList({
    super.key,
    required this.completedPrayers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        if (state is PrayerLoading) {
          return const CircularProgressIndicator();
        }

        final cubit = context.read<PrayerCubit>();

        return Column(
          children: List.generate(
            completedPrayers.length,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: InkWell(
                onTap: () => onChanged(index),
                child: PrayerTrackerItem(
                  title: Constants.prayerWithoutShurooq[index].name,
                  time: DateFormat('hh:mm').format(
                    cubit.prayerTimes
                        .firstWhere(
                          (e) =>
                              e.key ==
                              Constants.prayerWithoutShurooq[index].name,
                        )
                        .value,
                  ),
                  isSelected: completedPrayers[index],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
