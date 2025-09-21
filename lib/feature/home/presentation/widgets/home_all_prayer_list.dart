import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_prayer_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAllPrayerList extends StatefulWidget {
  const HomeAllPrayerList({super.key});

  @override
  State<HomeAllPrayerList> createState() => _HomeAllPrayerListState();
}

class _HomeAllPrayerListState extends State<HomeAllPrayerList> {
  int selectedPrayerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        final cubit = context.read<PrayerCubit>();
        if (state is PrayerLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                Constants.prayer.length,
                (index) => HomePrayerItem(
                  time: DateFormat(
                    'hh:mm',
                  ).format(cubit.prayerTimes[index].value),
                  isSelected:
                      Constants.prayer[index].name == cubit.getCurrentPrayer(),
                  title: Constants.prayer[index].name,
                  icon: Constants.prayer[index].icon,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
