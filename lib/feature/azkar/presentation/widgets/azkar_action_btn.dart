import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/azkar_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:al_huda/feature/favorite/presentation/manager/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarActionBtn extends StatelessWidget {
  final int count;
  final bool? isFav;
  final Zikr? zikr;
  final int? index;
  final String? title;
  final VoidCallback? onCountComplete;
  const AzkarActionBtn({
    super.key,
    required this.count,
    this.zikr,
    this.isFav = false,
    this.index,
    this.title,
    this.onCountComplete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final cubit = context.read<FavoriteCubit>();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isFav == true
                ? GestureDetector(
                    onTap: () {
                      if (index != null) {
                        cubit.deleteAzkarById(zikr!.id);
                      }
                    },
                    child: Icon(
                      Icons.delete,
                      color: ColorManager.red,
                      size: 24.sp,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      if (cubit.isFav(zikr!)) {
                        cubit.deleteAzkarById(zikr!.id);
                      } else {
                        cubit.addAzkar(zikr!);
                      }
                    },
                    child: SvgIcon(
                      assetName: AppIcons.heart,
                      color: zikr != null
                          ? context.read<FavoriteCubit>().isFav(zikr!)
                                ? ColorManager.red
                                : ColorManager.primary
                          : ColorManager.primary,
                    ),
                  ),
            horizontalSpace(24),
            count == 0
                ? SvgIcon(
                    assetName: AppIcons.check,
                    color: ColorManager.primary,
                    width: 43.w,
                    height: 43.h,
                  )
                : GestureDetector(
                    onTap: () {
                      if (onCountComplete != null) {
                        onCountComplete!();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorManager.primary,
                          width: 2,
                        ),

                        color: ColorManager.white,
                      ),
                      child: Text(
                        count.toString(),
                        style: TextSTyle.f14CairoBoldPrimary.copyWith(
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
            horizontalSpace(24),

            GestureDetector(
              onTap: () {
                AzkarServices.copyText(zikr?.text ?? title ?? "");
              },
              child: Icon(Icons.copy, color: ColorManager.primary, size: 24.sp),
            ),
          ],
        );
      },
    );
  }
}
