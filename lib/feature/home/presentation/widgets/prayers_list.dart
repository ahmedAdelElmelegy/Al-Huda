import 'package:al_huda/feature/allah_name/presentation/screens/allah_name_screen.dart';
import 'package:al_huda/feature/azkar/presentation/screens/azkar_screen.dart';
import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/feature/home/presentation/widgets/prayer_item.dart';
import 'package:al_huda/feature/nearst_mosque/presentation/screens/nearest_mosque_screen.dart';
import 'package:al_huda/feature/radio/presentation/screens/radio_screen.dart';
import 'package:al_huda/feature/tasbeh/presentation/screens/tasbeh_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayersList extends StatelessWidget {
  const PrayersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      width: double.infinity,
      height: 300.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.bg),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Align(
          alignment: Alignment.topCenter,
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: .83,
              mainAxisSpacing: 8.h,
              crossAxisSpacing: 8.w,
            ),
            children: [
              InkWell(
                onTap: () {
                  push(AzkarScreen());
                },
                child: PrayerItem(title: 'azkar'.tr(), icon: AppIcons.salah),
              ),
              InkWell(
                onTap: () {
                  push(TasbehScreen());
                },
                child: PrayerItem(title: 'tasbeh'.tr(), icon: AppIcons.tasbih),
              ),
              InkWell(
                onTap: () {
                  push(RadioScreen());
                },
                child: PrayerItem(title: 'radio'.tr(), icon: AppIcons.radio),
              ),
              InkWell(
                onTap: () {
                  push(AllahNameScreen());
                },
                child: PrayerItem(
                  title: 'allah_name'.tr(),
                  icon: AppIcons.allah,
                ),
              ),
              InkWell(
                onTap: () {
                  push(NearestMosqueScreen());
                },
                child: PrayerItem(
                  title: 'nearest_mosque'.tr(),
                  icon: AppIcons.mosque,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
