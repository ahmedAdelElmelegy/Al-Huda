import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClearAppBar extends StatelessWidget {
  const ClearAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Center(child: Text(title, style: TextSTyle.f18SSTArabicMediumPrimary)),
        InkWell(
          onTap: () {
            pop();
          },
          child: SvgIcon(
            assetName: AppIcons.clear,
            color: ColorManager.primaryText2,
            width: 15.w,
            height: 15.h,
          ),
        ),
      ],
    );
  }
}
