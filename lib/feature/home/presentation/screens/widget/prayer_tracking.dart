import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/complete_prayer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce/hive.dart';
import 'package:intl/intl.dart';

class PrayerTracking extends StatefulWidget {
  const PrayerTracking({super.key});

  @override
  State<PrayerTracking> createState() => _PrayerTrackingState();
}

class _PrayerTrackingState extends State<PrayerTracking> {
  List<bool> completedPrayers = List.generate(5, (_) => false);
  late Box box;
  static const String prefKey = 'completed_prayers';

  @override
  void initState() {
    super.initState();
    box = Hive.box('completedPrayersBox');
    _loadPrayersFromHive();
  }

  void _loadPrayersFromHive() {
    final saved = box.get(prefKey);

    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (saved != null && saved is Map) {
      String savedDate = saved['date'] ?? '';
      List savedValues = saved['values'] ?? [];

      if (savedDate == today) {
        // نفس اليوم → استخدم القيم المخزنة
        setState(() {
          completedPrayers = List<bool>.from(savedValues);
        });
      } else {
        // يوم جديد → reset للقيم
        setState(() {
          completedPrayers = List.generate(5, (_) => false);
        });
        _savePrayersToHive(); // نحفظ مع التاريخ الجديد
      }
    } else {
      // مفيش بيانات → نعمل reset
      _savePrayersToHive();
    }
  }

  void _savePrayersToHive() {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    box.put(prefKey, {"date": today, "values": completedPrayers});
  }

  void togglePrayer(int index) {
    setState(() {
      completedPrayers[index] = !completedPrayers[index];
    });
    _savePrayersToHive();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: ColorManager.greyLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الصلوات المكتملة', style: TextSTyle.f14CairoBoldPrimary),
          verticalSpace(16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: ColorManager.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                5,
                (index) => CompletePrayerItem(
                  index: index,
                  isDone: completedPrayers[index],
                  onTap: () => togglePrayer(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
