import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/feature/azkar/presentation/screens/azkar_detail_screen.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/azkar_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarDetailBody extends StatelessWidget {
  const AzkarDetailBody({super.key, required this.widget});

  final AzkarDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(24),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.zikr.length,
                itemBuilder: (context, index) {
                  return AzkarDetailItem(
                    index: index + 1,
                    zikr: widget.zikr[index],
                  );
                },
              ),
              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
