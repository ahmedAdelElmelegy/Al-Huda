import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/tasbeh/data/model/tasbeh_model.dart';
import 'package:al_huda/feature/tasbeh/presentation/manager/tasbeh/tasbeh_cubit.dart';
import 'package:al_huda/feature/tasbeh/presentation/widgets/tasbeh_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TasbehItem extends StatelessWidget {
  final bool isSelected;

  final int index;
  final TasbehModel tasbeh;
  const TasbehItem({
    super.key,
    this.isSelected = false,
    required this.tasbeh,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TasbehCubit>();
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: isSelected
            ? Border.all(color: ColorManager.blue, width: 3.w)
            : null,
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              tasbeh.name,
              style: TextSTyle.f16AmiriBoldPrimary,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          !cubit.isEdit
              ? tasbeh.lock
                    ? InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    verticalSpace(16),
                                    Text(
                                      'please'.tr(),
                                      style: TextSTyle.f16AmiriBoldPrimary,
                                    ),
                                    verticalSpace(8),
                                    Text(
                                      'no_delete'.tr(),
                                      style: TextSTyle.f12CairoRegGrey.copyWith(
                                        color: ColorManager.black,
                                      ),
                                    ),
                                    verticalSpace(16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TasbehBtn(
                                        isFullRadius: true,
                                        onPressed: () {
                                          pop();
                                        },
                                        text: 'cancel'.tr(),
                                        color: ColorManager.primaryText2,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.sp),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.gray,
                          ),
                          child: SvgIcon(
                            assetName: AppIcons.lock,
                            color: ColorManager.white,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    verticalSpace(16),
                                    Text(
                                      'delete_title'.tr(),
                                      style: TextSTyle.f16AmiriBoldPrimary,
                                    ),
                                    verticalSpace(8),
                                    Text(
                                      'delete_message'.tr(),
                                      style: TextSTyle.f12CairoRegGrey.copyWith(
                                        color: ColorManager.black,
                                      ),
                                    ),
                                    verticalSpace(16),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TasbehBtn(
                                            radiusDirection: true,
                                            color: ColorManager.red,
                                            text: 'delete'.tr(),
                                            onPressed: () {
                                              cubit.deleteTasbeh(index);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: TasbehBtn(
                                            text: 'cancel'.tr(),
                                            onPressed: () {
                                              pop();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.sp),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.red,
                          ),
                          child: SvgIcon(
                            assetName: AppIcons.delete,
                            color: ColorManager.white,
                          ),
                        ),
                      )
              // count
              : Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.primaryText2,
                    borderRadius: BorderRadius.circular(20.r),
                  ),

                  child: Text(
                    tasbeh.count.toString(),
                    style: TextSTyle.f16CairoMediumBlack.copyWith(
                      color: ColorManager.white,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
