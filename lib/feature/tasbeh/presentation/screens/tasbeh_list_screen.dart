import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/tasbeh/presentation/manager/tasbeh/tasbeh_cubit.dart';
import 'package:al_huda/feature/tasbeh/presentation/widgets/add_new_tasbeh.dart';
import 'package:al_huda/feature/tasbeh/presentation/widgets/tasbeh_list_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TasbehListScreen extends StatefulWidget {
  const TasbehListScreen({super.key});

  @override
  State<TasbehListScreen> createState() => _TasbehListScreenState();
}

class _TasbehListScreenState extends State<TasbehListScreen> {
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                verticalSpace(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AddNewTaskbeh(),
                    Text(
                      'tasbeh_list'.tr(),
                      style: TextSTyle.f18CairoMediumBlack.copyWith(
                        color: ColorManager.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final cubit = context.read<TasbehCubit>();
                        if (!cubit.isEdit) {
                          cubit.changeEditState();
                        } else {
                          pop();
                        }
                      },
                      child: SvgIcon(
                        assetName: AppIcons.clear,
                        color: ColorManager.white,
                        width: 16.w,
                        height: 16.h,
                      ),
                    ),
                  ],
                ),
                verticalSpace(36),
                TasbehListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
