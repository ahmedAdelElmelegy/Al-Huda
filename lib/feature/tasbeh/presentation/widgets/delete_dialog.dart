import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/tasbeh/presentation/manager/tasbeh/tasbeh_cubit.dart';
import 'package:al_huda/feature/tasbeh/presentation/widgets/tasbeh_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<dynamic> deleteDialog(
  BuildContext context,
  TasbehCubit cubit,
  int index,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(16),
            Text('delete_title'.tr(), style: TextSTyle.f16AmiriBoldPrimary),
            verticalSpace(8),
            Text(
              'delete_message'.tr(),
              style: TextSTyle.f12CairoRegGrey.copyWith(
                color: ColorManager.black,
              ),
            ),
            verticalSpace(16),
            Row(
              children: [
                Expanded(
                  child: TasbehBtn(
                    radiusDirection: true,
                    color: ColorManager.red,
                    text: 'delete'.tr(),
                    onPressed: () {
                      cubit.deleteTasbeh(index);
                    },
                  ),
                ),
                Expanded(
                  child: TasbehBtn(
                    text: 'cancel'.tr(),
                    onPressed: () {
                      pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
