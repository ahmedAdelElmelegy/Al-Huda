import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/calender_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventItem extends StatelessWidget {
  final String name;
  final DateTime date;
  final int remainingDays;

  const EventItem({
    super.key,
    required this.name,
    required this.date,
    required this.remainingDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorManager.primaryBg,
        border: Border.all(color: ColorManager.primary, width: .5.w),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextSTyle.f14SSTArabicMediumPrimary,

              maxLines: 1,
            ),
          ),

          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    DateFormat('yyyy/MM/dd', 'ar').format(date),
                    style: TextSTyle.f12CairoBoldGrey,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                horizontalSpace(4),
                Flexible(
                  flex: 1,
                  child: Text(
                    '${tr('remaining')} ${CalenderServices.toArabicNumber(remainingDays)} ${tr('days')}',
                    style: TextSTyle.f12CairoSemiBoldPrimary.copyWith(
                      color: ColorManager.primaryText2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
