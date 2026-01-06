import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/prayer_traker_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimeList extends StatefulWidget {
  final Function(int index) onChanged;
  const PrayerTimeList({super.key, required this.onChanged});

  @override
  State<PrayerTimeList> createState() => _PrayerTimeListState();
}

class _PrayerTimeListState extends State<PrayerTimeList> {
  List<bool> isSelected = List.generate(
    Constants.prayer.length,
    (index) => false,
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        if (state is PrayerLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final cubit = context.read<PrayerCubit>();

        return Column(
          children: List.generate(
            Constants.prayer.length,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isSelected[index] = !isSelected[index];
                    widget.onChanged(index);
                  });
                },
                child: PrayerTrackerItem(
                  title: Constants.prayer[index].name,
                  time: DateFormat(
                    'hh:mm',
                  ).format(cubit.prayerTimes[index].value),
                  isSelected: isSelected[index],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
