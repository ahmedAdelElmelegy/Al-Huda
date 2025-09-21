import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/tasbeh/presentation/manager/tasbeh/tasbeh_cubit.dart';
import 'package:al_huda/feature/tasbeh/presentation/screens/tasbeh_list_screen.dart';
import 'package:al_huda/feature/tasbeh/presentation/widgets/tasbeh_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TasbehScreen extends StatefulWidget {
  const TasbehScreen({super.key});

  @override
  State<TasbehScreen> createState() => _TasbehScreenState();
}

class _TasbehScreenState extends State<TasbehScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TasbehCubit>();
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      pop();
                    },
                    child: SvgIcon(
                      assetName: AppIcons.clear,
                      color: ColorManager.white,
                      width: 15.w,
                      height: 15.h,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cubit.resetTasbeh();
                    },
                    child: SvgIcon(
                      assetName: AppIcons.reset,
                      width: 20.w,
                      height: 20.h,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
              TasbehBody(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: ColorManager.white.withValues(alpha: .1),
        shape: const CircleBorder(),
        onPressed: () {
          push(TasbehListScreen());
        },
        child: SvgIcon(assetName: AppIcons.tasbih, color: ColorManager.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
