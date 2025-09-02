import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/prayer_time/presentation/screens/setting_prayer_time_screen.dart';
import 'package:al_huda/feature/settings/presentation/screens/setting_azkar_screen.dart';
import 'package:al_huda/feature/settings/presentation/screens/qran_setting_screen.dart';
import 'package:al_huda/feature/settings/presentation/widgets/setting_action_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingScreenAction extends StatelessWidget {
  const SettingScreenAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            push(SettingPrayerTimeScreen());
          },
          child: SettingActionBtn(title: 'prayers_time'.tr()),
        ),
        verticalSpace(16),
        InkWell(
          onTap: () {
            push(QranSettingScreen());
          },
          child: SettingActionBtn(title: 'qran_setting'.tr()),
        ),
        verticalSpace(16),
        InkWell(
          onTap: () {
            push(SettingAzkarScreen());
          },
          child: SettingActionBtn(title: 'azkar_setting'.tr()),
        ),
        verticalSpace(16),
        SettingActionBtn(
          title: 'app_version'.tr(),
          child: Row(
            children: [
              Text(
                '1.0.0 ${tr('version')}',
                style: TextSTyle.f14CairoRegularPrimary.copyWith(
                  color: ColorManager.primaryText,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(16),
      ],
    );
  }
}
