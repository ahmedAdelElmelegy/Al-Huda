import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/notification/notification_services.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/settings/presentation/widgets/setting_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timezone/timezone.dart' as tz;

class SettingPrayerTimeScreen extends StatelessWidget {
  const SettingPrayerTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: 'prayer_time'.tr()),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            children: List.generate(
              Constants.prayer.length,
              (index) => PrayerTimeDetailItem(
                index: index,
                title: Constants.prayer[index].name.tr(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrayerTimeDetailItem extends StatefulWidget {
  final String title;

  final int index;
  const PrayerTimeDetailItem({
    super.key,
    required this.title,
    required this.index,
  });

  @override
  State<PrayerTimeDetailItem> createState() => _PrayerTimeDetailItemState();
}

class _PrayerTimeDetailItemState extends State<PrayerTimeDetailItem> {
  bool value = true;

  @override
  void initState() {
    super.initState();
    PrayerServices.getSwitchState(widget.index, Constants.keyPrefix).then((
      value,
    ) {
      setState(() {
        this.value = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      color: ColorManager.greyLight,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          SvgIcon(
            assetName: AppIcons.on,
            color: ColorManager.gray,
            width: 20.w,
            height: 20.h,
          ),
          horizontalSpace(8),
          Text(
            widget.title,
            style: TextSTyle.f14CairoSemiBoldPrimary.copyWith(
              color: ColorManager.gray,
            ),
          ),
          horizontalSpace(16),
          const Spacer(),
          SettingSwitch(
            value: value,
            onChanged: (newValue) {
              setState(() {
                value = newValue;
              });
              PrayerServices.saveSwitchState(
                widget.index,
                newValue,
                Constants.keyPrefix,
              );

              if (!newValue) {
                NotificationService.cancelNotification(widget.index);
              } else {
                final cubit = context.read<PrayerCubit>();
                final prayerTime = cubit.prayerTimes[widget.index];
                final scheduledTime = tz.TZDateTime.from(
                  prayerTime.value,
                  tz.local,
                );
                NotificationService.scheduleNotification(
                  widget.index,
                  'حان الآن موعد ${prayerTime.key.tr()}',
                  'وقت الصلاة: ${prayerTime.key.tr()}',
                  scheduledTime,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
