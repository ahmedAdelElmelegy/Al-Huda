import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';
import 'package:al_huda/feature/radio/presentation/widgets/radio_reader_list_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: CustomAppBarWithArrow(title: 'radio'.tr(), icon: AppIcons.radio),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [verticalSpace(24), RadioReaderListView()]),
        ),
      ),
    );
  }
}
