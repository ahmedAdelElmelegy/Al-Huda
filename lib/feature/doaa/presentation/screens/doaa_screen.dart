import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/custom_bg_app_bar.dart';

import 'package:al_huda/feature/azkar/presentation/widgets/azkar_item.dart';

import 'package:al_huda/feature/doaa/presentation/widgets/doaa_detail_screen.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoaaScreen extends StatelessWidget {
  const DoaaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              collapsedHeight: 150.h,
              flexibleSpace: CustomBgAppBar(
                bgImage: AppImages.doaaBg,
                logoImage: AppImages.doaaLogo,
              ),
              automaticallyImplyLeading: false,
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return GestureDetector(
                    onTap: () {
                      push(
                        DoaaDetailsScreen(
                          title: Constants.doaaNameList[index].tr(),
                          data: AppURL.doaaListUrl[index],
                        ),
                      );
                    },
                    child: AzkarItem(name: Constants.doaaNameList[index].tr()),
                  );
                }, childCount: Constants.doaaNameList.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
