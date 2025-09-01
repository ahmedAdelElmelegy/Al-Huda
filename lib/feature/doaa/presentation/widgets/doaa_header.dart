import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/services/azkar_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/doaa/data/model/doaa_model.dart';
import 'package:al_huda/feature/favorite/presentation/manager/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoaaHeader extends StatefulWidget {
  final DoaaModelData doaaModelData;
  final int index;
  final int? doaaHeaderIndex;
  const DoaaHeader({
    super.key,
    required this.doaaModelData,
    required this.index,
    this.doaaHeaderIndex,
  });

  @override
  State<DoaaHeader> createState() => _DoaaHeaderState();
}

class _DoaaHeaderState extends State<DoaaHeader> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.doaaHeaderIndex != null) {
        context.read<FavoriteCubit>().getDoaaByCategory(
          Constants.doaaNameList[widget.doaaHeaderIndex!],
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final cubit = context.read<FavoriteCubit>();
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.doaaHeaderIndex == null
                  ? GestureDetector(
                      onTap: () {
                        context.read<FavoriteCubit>().deleteDoaa(widget.index);
                      },
                      child: SvgIcon(
                        assetName: AppIcons.delete,
                        width: 16.w,
                        height: 16.h,
                        color: ColorManager.red,
                      ),
                    )
                  : cubit.isDoaaInFavorite(widget.doaaModelData)
                  ? SvgIcon(
                      assetName: AppIcons.favorite,
                      width: 16.w,
                      height: 16.h,
                      color: ColorManager.red,
                    )
                  : GestureDetector(
                      onTap: () {
                        context.read<FavoriteCubit>().addDoaa(
                          widget.doaaModelData,
                          widget.doaaHeaderIndex!,
                        );
                      },
                      child: SvgIcon(
                        assetName: AppIcons.favorite,
                        width: 16.w,
                        height: 16.h,
                        color: ColorManager.white,
                      ),
                    ),
              GestureDetector(
                onTap: () {
                  AzkarServices.copyText(widget.doaaModelData.text);
                },
                child: SvgIcon(
                  assetName: AppIcons.copy,
                  width: 16.w,
                  height: 16.h,
                  color: ColorManager.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
