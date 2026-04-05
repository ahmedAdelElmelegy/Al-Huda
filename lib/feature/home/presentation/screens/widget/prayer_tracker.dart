import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/prayer_time/presentation/widgets/prayer_time_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class PrayerTraker extends StatefulWidget {
  const PrayerTraker({super.key});

  @override
  State<PrayerTraker> createState() => _PrayerTrakerState();
}

class _PrayerTrakerState extends State<PrayerTraker> {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.gray.withValues(alpha: .3)),
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'prayer_tracking'.tr(),
                        style: TextSTyle.f14SSTArabicMediumPrimary,
                      ),
                      verticalSpace(4),
                      Text(
                        'keep_up_with_your_daily_salah'.tr(),
                        style: TextSTyle.f12SSTArabicRegBlack.copyWith(
                          color: ColorManager.gray,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Complete ${completedPrayers.where((e) => e).length}/5',
                    style: TextSTyle.f12CairoBoldGrey.copyWith(
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(16),
            Divider(color: ColorManager.gray.withValues(alpha: .3)),
            verticalSpace(16),
            PrayerTimeList(
              completedPrayers: completedPrayers,
              onChanged: togglePrayer,
            ),
          ],
        ),
      ),
    );
  }
}
