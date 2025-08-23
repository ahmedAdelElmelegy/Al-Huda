import 'package:al_huda/feature/azkar/presentation/widgets/azkar_detail_item.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarDetailScreen extends StatelessWidget {
  const AzkarDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: 'azkar_prayer'.tr()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                verticalSpace(24),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return AzkarDetailItem(index: index + 1);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
