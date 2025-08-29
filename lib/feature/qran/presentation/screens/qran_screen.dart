import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/qran/presentation/widgets/surah_list_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class QranScreen extends StatelessWidget {
  const QranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgIcon(
                    assetName: AppIcons.qranA,
                    color: ColorManager.primaryText2,
                  ),
                  horizontalSpace(8),
                  Text(
                    'quran'.tr(),
                    style: TextSTyle.f18CairoSemiBoldPrimary.copyWith(
                      color: ColorManager.primaryText2,
                    ),
                  ),
                ],
              ),
              verticalSpace(24),
              SurahListView(),
            ],
          ),
        ),
      ),
    );
  }
}
