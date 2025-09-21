import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletePrayerItem extends StatelessWidget {
  final bool isDone;
  final int index;
  final VoidCallback onTap;

  const CompletePrayerItem({
    super.key,
    required this.isDone,
    required this.index,
    required this.onTap,
  });

  List<String> get prayerNames => ['fagr', 'dhuhr', 'asr', 'maghrib', 'isha'];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 24.h,
            width: 24.w,
            child: Checkbox(
              value: isDone,
              onChanged: (_) => onTap(),
              activeColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          verticalSpace(8),
          Text(
            prayerNames[index].tr(),
            style: TextSTyle.f14SSTArabicMediumPrimary.copyWith(
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
    );
  }
}
