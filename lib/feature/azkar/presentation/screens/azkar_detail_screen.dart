import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/azkar_detail_item.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarDetailScreen extends StatelessWidget {
  final List<Zikr> zikr;
  final String zikrName;
  const AzkarDetailScreen({
    super.key,
    required this.zikr,
    required this.zikrName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: zikrName),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                verticalSpace(24),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: zikr.length,
                  itemBuilder: (context, index) {
                    return AzkarDetailItem(index: index + 1, zikr: zikr[index]);
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
