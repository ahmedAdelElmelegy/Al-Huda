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
            onChanged: (newValue) async {
              setState(() {
                value = newValue;
              });

              // حفظ الحالة في الـ SharedPreferences
              await PrayerServices.saveSwitchState(
                widget.index,
                newValue,
                Constants.keyPrefixAzkar,
              );

              // إلغاء أي إشعار موجود بنفس الـ ID
              final notificationId = 1000 + widget.index;
              await NotificationService.cancelNotification(notificationId);

              if (newValue) {
                if (widget.index == 2) {
                  await NotificationService.showPeriodicallyNotification(
                    notificationId,
                    widget.title,
                    "صلي الله عليه وسلم",
                    sound: 'salyalmohamed',
                  );
                } else {
                  final hour = widget.index == 0 ? 6 : 18;
                  final sound = widget.index == 0
                      ? 'azkarsabahh'
                      : 'azkarmassaa';

                  await NotificationService.scheduleNotification(
                    notificationId,
                    widget.title,
                    widget.index == 0 ? "اذكر الله صباحك" : "اذكر الله مساءك",
                    PrayerServices.calculateDataTime(hour, 0),
                    sound: sound,
                    chanelId: widget.index == 0
                        ? Constants.azkarAlsabahChannelId
                        : Constants.azkarElmassaaChannelId,
                    chanelName: widget.index == 0
                        ? "أذكار الصباح"
                        : "أذكار المساء",
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
