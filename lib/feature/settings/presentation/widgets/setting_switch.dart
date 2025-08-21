import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingSwitch extends StatefulWidget {
  const SettingSwitch({super.key});

  @override
  State<SettingSwitch> createState() => _SettingSwitchState();
}

class _SettingSwitchState extends State<SettingSwitch> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      child: Switch(
        activeTrackColor: ColorManager.primary,
        activeColor: ColorManager.white,
        value: value,
        onChanged: (value) {
          setState(() {
            this.value = value;
          });
        },
      ),
    );
  }
}
