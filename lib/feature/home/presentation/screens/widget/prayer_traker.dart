import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/prayer_time/presentation/widgets/prayer_time_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTraker extends StatefulWidget {
  const PrayerTraker({super.key});

  @override
  State<PrayerTraker> createState() => _PrayerTrakerState();
}

class _PrayerTrakerState extends State<PrayerTraker> {
  int selectedPrayerIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        // height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.gray.withValues(alpha: 0.3)),
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
                    color: ColorManager.primary.withValues(alpha: .8),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Complete  ${selectedPrayerIndex + 1}/ 5'.tr(),
                    style: TextSTyle.f12CairoBoldGrey.copyWith(
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(16),
            Divider(color: ColorManager.gray, thickness: .3),
            verticalSpace(16),
            PrayerTimeList(
              onChanged: (index) {
                setState(() {
                  selectedPrayerIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
