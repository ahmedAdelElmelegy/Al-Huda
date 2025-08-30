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
      height: 16.h,

      child: Switch(
        activeTrackColor: ColorManager.primary,
        activeColor: ColorManager.white,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

// //  Checkbox(
//         side: BorderSide(color: ColorManager.primary, width: 2.w),
//         activeColor: ColorManager.primary,
//         checkColor: ColorManager.white,
//         shape: CircleBorder(),
//         value: value,
//         onChanged: (value) {
//           onChanged!(value!);
//         },
//       ),
