import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/prayer_time/presentation/screens/prayer_time_detail_screen.dart';
import 'package:al_huda/feature/settings/presentation/screens/qran_setting_screen.dart';
import 'package:al_huda/feature/settings/presentation/widgets/setting_action_btn.dart';
import 'package:al_huda/feature/settings/presentation/widgets/setting_switch.dart';
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
            push(PrayerTimeDetailScreen());
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
        SettingActionBtn(title: 'english'.tr(), child: SettingSwitch()),
        verticalSpace(16),
        SettingActionBtn(
          title: 'update_location'.tr(),
          child: Row(
            children: [
              Text(
                'location'.tr(),
                style: TextSTyle.f8CairoSemiBoldWhite.copyWith(
                  color: Colors.black,
                ),
              ),
              horizontalSpace(8),
              SvgIcon(assetName: AppIcons.update),
            ],
          ),
        ),
        verticalSpace(16),
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
      ],
    );
  }
}
