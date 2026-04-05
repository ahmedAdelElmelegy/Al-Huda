import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';

import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/settings/presentation/widgets/setting_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    PrayerServices.getSwitchState(widget.index, Constants.keyPrefix).then((v) {
      setState(() {
        value = v;
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
          onChanged: (newValue) async {
            setState(() {
              value = newValue;
            });

            // Save sound preference toggle for this prayer index
            // keyPrefix is used for showing/hiding notification,
            // keyPrefixNotification is used for sound/silent in scheduling
            await PrayerServices.saveSwitchState(
              widget.index,
              newValue,
              Constants.keyPrefix,
            );
            await PrayerServices.saveSwitchState(
              widget.index,
              newValue,
              Constants.keyPrefixNotification,
            );

            // Reschedule ALL prayer notifications for the next 3 days
            // This applies the updated sound preference across all scheduled times
            await PrayerServices.schedulePrayerNotifications();

          },
        ),
      ],
    );
  }
}
