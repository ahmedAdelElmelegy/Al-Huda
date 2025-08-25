import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class QranNumberItem extends StatelessWidget {
  final int number;
  const QranNumberItem({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgIcon(assetName: AppIcons.number, width: 48, height: 48),
        Text(
          number.toString(),
          style: TextSTyle.f16CairoMediumBlack.copyWith(
            color: ColorManager.primaryText2,
          ),
        ),
      ],
    );
  }
}
