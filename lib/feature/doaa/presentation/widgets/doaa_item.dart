import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/doaa/data/model/doaa_model.dart';
import 'package:al_huda/feature/doaa/presentation/widgets/doaa_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoaaItem extends StatelessWidget {
  final DoaaModelData doaaModelData;
  final int index;
  final int? doaaHeaderIndex;
  const DoaaItem({
    super.key,
    required this.doaaModelData,
    required this.index,
    this.doaaHeaderIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: ColorManager.greyLight,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.gray.withValues(alpha: 0.3),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DoaaHeader(
            doaaModelData: doaaModelData,
            index: index,
            doaaHeaderIndex: doaaHeaderIndex,
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: SingleChildScrollView(
                child: Text(
                  doaaModelData.text,
                  style: TextSTyle.f16SSTArabicRegBlack,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              doaaModelData.info,
              style: TextSTyle.f14CairoSemiBoldPrimary,
            ),
          ),
          verticalSpace(16),
        ],
      ),
    );
  }
}
