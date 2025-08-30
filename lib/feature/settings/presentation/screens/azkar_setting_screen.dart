import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';
import 'package:al_huda/feature/prayer_time/presentation/screens/azkar_setting_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AzkarSettingScreen extends StatelessWidget {
  const AzkarSettingScreen({super.key});
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
        child: Column(
          children: List.generate(
            azkar.length,
            (index) => AzkarSettingItem(title: azkar[index].tr(), index: index),
          ),
        ),
      ),
    );
  }
}
