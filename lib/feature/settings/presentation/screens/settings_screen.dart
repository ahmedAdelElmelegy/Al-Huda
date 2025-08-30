import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/feature/prayer_time/presentation/widgets/custom_app_bar.dart';
import 'package:al_huda/feature/settings/presentation/widgets/setting_screen_action.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'settings'.tr(),
        icon: AppIcons.settingActive,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [verticalSpace(24), SettingScreenAction()]),
        ),
      ),
    );
  }
}
