import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';
import 'package:al_huda/feature/settings/presentation/widgets/setting_azkar_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingAzkarScreen extends StatelessWidget {
  const SettingAzkarScreen({super.key});
  static List<String> azkar = [
    "azkar_sabah",
    "azkar_massaa",
    "sally_al_mohamed",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: 'azkar_setting'.tr()),
      body: SafeArea(
        child: SingleChildScrollView(child: SettingAzkarList(azkar: azkar)),
      ),
    );
  }
}
