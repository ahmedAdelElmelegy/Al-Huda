import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/notification/notification_services.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/settings/presentation/widgets/setting_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timezone/timezone.dart' as tz;

class SettingPrayerItem extends StatefulWidget {
  final String title;
  final String? icon;
  final int index;
  const SettingPrayerItem({
    super.key,
    required this.title,
    required this.index,
    this.icon,
  });

  @override
  State<SettingPrayerItem> createState() => _SettingPrayerItemState();
}

class _SettingPrayerItemState extends State<SettingPrayerItem> {
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
    return Row(
      children: [
        SvgIcon(
          assetName: widget.icon ?? AppIcons.on,
          color: ColorManager.primary,
          width: 20.w,
          height: 20.h,
        ),
        horizontalSpace(8),
        Text(
          widget.title,
          style: TextSTyle.f14SSTArabicBoldWhite.copyWith(
            color: ColorManager.primaryText2,
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
                prayer: true,
                payload: 'prayer',
              );
            }
          },
        ),
      ],
    );
  }
}
