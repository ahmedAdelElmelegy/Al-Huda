import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/notification/notification_services.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/home/data/model/prayer_model.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimeItem extends StatefulWidget {
  final PrayerModel prayer;
  final bool? isSelected;
  final String time;
  final int index;
  const PrayerTimeItem({
    super.key,
    required this.prayer,
    this.isSelected = false,
    required this.time,
    required this.index,
  });

  @override
  State<PrayerTimeItem> createState() => _PrayerTimeItemState();
}

class _PrayerTimeItemState extends State<PrayerTimeItem> {
  bool value = true;

  @override
  void initState() {
    super.initState();
    PrayerServices.getSwitchState(
      widget.index,
      Constants.keyPrefixNotification,
    ).then((value) {
      setState(() {
        this.value = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PrayerCubit>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: widget.isSelected == true
            ? ColorManager.primaryBg
            : Colors.transparent,
      ),
      child: Row(
        children: [
          SvgIcon(
            assetName: widget.prayer.icon,
            color: widget.isSelected == true
                ? ColorManager.primary
                : ColorManager.gray,
          ),
          horizontalSpace(8),
          Text(
            widget.prayer.name.tr(),
            style: TextSTyle.f14CairoSemiBoldPrimary.copyWith(
              color: widget.isSelected == true
                  ? ColorManager.primary
                  : ColorManager.gray,
            ),
          ),
          horizontalSpace(16),
          Spacer(),
          InkWell(
            onTap: () async {
              setState(() {
                value = !value;
              });

              await PrayerServices.saveSwitchState(
                widget.index,
                value,
                Constants.keyPrefixNotification,
              );

              if (mounted) {
                // ignore: use_build_context_synchronously
                final prayerTime = cubit.prayerTimes[widget.index];

                await NotificationService.cancelNotification(widget.index);

                await NotificationService.scheduleNotification(
                  widget.index,
                  'حان الآن موعد ${prayerTime.key.tr()}',
                  'وقت الصلاة: ${prayerTime.key.tr()}',
                  prayerTime.value,
                  prayer: true,
                  playSound: value,
                );
              }
            },
            child: SvgIcon(
              assetName: value == true ? AppIcons.on : AppIcons.mute,
              height: 20.w,
              width: 20.h,
              color: widget.isSelected == true
                  ? ColorManager.primary
                  : ColorManager.gray,
            ),
          ),
          horizontalSpace(10),
          Text(
            widget.time,
            style: TextSTyle.f16CairoMediumBlack.copyWith(
              color: widget.isSelected == true
                  ? ColorManager.primary
                  : ColorManager.gray,
            ),
          ),
        ],
      ),
    );
  }
}
