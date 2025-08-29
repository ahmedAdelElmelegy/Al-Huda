import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/notification/notification_services.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/settings/presentation/widgets/setting_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarSettingItem extends StatefulWidget {
  final String title;

  final int index;
  const AzkarSettingItem({super.key, required this.title, required this.index});

  @override
  State<AzkarSettingItem> createState() => _AzkarSettingItemState();
}

class _AzkarSettingItemState extends State<AzkarSettingItem> {
  bool value = true;

  @override
  void initState() {
    super.initState();
    PrayerServices.getSwitchState(widget.index, Constants.keyPrefixAzkar).then((
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
                Constants.keyPrefixAzkar,
              );

              NotificationService.cancelNotification(1000 + widget.index);

              if (newValue) {
                NotificationService.scheduleDailyNotification(
                  1000 + widget.index,
                  widget.title,
                  widget.index == 0 ? "اذكر الله صباحك" : "اذكر الله مساءك",
                  widget.index == 0 ? 6 : 18,
                  0,
                  sound: widget.index == 0 ? 'azkarsabahh' : 'azkarmassaa',
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
