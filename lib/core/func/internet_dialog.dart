import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/tasbeh/presentation/widgets/tasbeh_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<dynamic> internetDialog(
  BuildContext context, {
  void Function()? onPressed,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(16),
            Text('no_internet'.tr(), style: TextSTyle.f16AmiriBoldPrimary),
            verticalSpace(8),
            Text(
              'try_again'.tr(),
              style: TextSTyle.f12CairoRegGrey.copyWith(
                color: ColorManager.black,
              ),
            ),
            verticalSpace(16),

            TasbehBtn(
              radiusDirection: true,
              isFullRadius: true,
              color: ColorManager.primaryText2,
              text: 'refresh'.tr(),
              onPressed: onPressed,
            ),
          ],
        ),
      );
    },
  );
}
