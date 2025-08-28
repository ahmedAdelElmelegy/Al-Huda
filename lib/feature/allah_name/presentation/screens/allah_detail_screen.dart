import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/allah_name/data/model/allah_name_model.dart';
import 'package:al_huda/feature/allah_name/presentation/widgets/allah_detail_item.dart';
import 'package:al_huda/feature/allah_name/presentation/widgets/detail_frame.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllahDetailScreen extends StatelessWidget {
  final List<AllahName> allahNames;
  const AllahDetailScreen({super.key, required this.allahNames});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Center(
                      child: Text(
                        'allah_name'.tr(),
                        style: TextSTyle.f18SSTArabicMediumPrimary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        pop();
                      },
                      child: SvgIcon(
                        assetName: AppIcons.clear,
                        width: 14.w,
                        height: 14.h,
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        DetailFrame(name: allahNames[index].name),
                        verticalSpace(48),
                        AllahDetailItem(
                          index: index + 1,
                          name: allahNames[index].text,
                        ),
                      ],
                    );
                  },
                  itemCount: allahNames.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//  DetailFrame(name: name.name) AllahDetailItem(index: 1, name: name.text),
