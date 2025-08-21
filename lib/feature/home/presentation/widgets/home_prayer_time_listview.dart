import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/home/presentation/widgets/home_prayer_time_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePrayerTimeListView extends StatefulWidget {
  const HomePrayerTimeListView({super.key});

  @override
  State<HomePrayerTimeListView> createState() => _HomePrayerTimeListViewState();
}

class _HomePrayerTimeListViewState extends State<HomePrayerTimeListView> {
  int currentIndex = 0;
  List<String> prayerTimes = [
    'fagr',
    'shurooq',
    'dhuhr',
    'asr',
    'maghrib',
    'isha',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.primaryBg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      height: 90.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: prayerTimes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: HomePrayerTimeItem(
              isSelected: currentIndex == index,
              prayerTime: prayerTimes[index],
            ),
          );
        },
      ),
    );
  }
}
