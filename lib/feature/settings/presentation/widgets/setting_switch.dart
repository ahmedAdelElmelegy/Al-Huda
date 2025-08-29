import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SettingSwitch({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      child: Switch(
        activeTrackColor: ColorManager.primary,
        activeColor: ColorManager.white,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
