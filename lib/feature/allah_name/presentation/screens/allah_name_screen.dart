import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/custom_bg_app_bar.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/allah_name/presentation/manager/cubit/allah_name_cubit.dart';
import 'package:al_huda/feature/allah_name/presentation/widgets/allah_name_item.dart';
import 'package:al_huda/feature/allah_name/presentation/widgets/allah_name_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllahNameScreen extends StatelessWidget {
  const AllahNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              isLandscape
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                pop();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: ColorManager.primaryText2,
                                size: 24.sp,
                              ),
                            ),
                            horizontalSpace(8),
                            Text(
                              'allah_name'.tr(),
                              style: TextSTyle.f18SSTArabicMediumPrimary
                                  .copyWith(
                                    color: ColorManager.primaryText2,
                                    height: 1.6,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverAppBar(
                      collapsedHeight: 170.h,
                      flexibleSpace: CustomBgAppBar(
                        title: 'allah_name',
                        bgImage: AppImages.allahImageBg,
                        logoImage: AppImages.allahLogo,
                      ),
                      automaticallyImplyLeading: false,
                    ),
              BlocBuilder<AllahNameCubit, AllahNameState>(
                builder: (context, state) {
                  final cubit = context.read<AllahNameCubit>();
                  if (state is AllahNameLoading) {
                    return SliverToBoxAdapter(child: LoadingListView());
                  } else if (state is AllahNameError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'error'.tr(),
                          style: TextSTyle.f16AmiriBoldPrimary,
                        ),
                      ),
                    );
                  }
                  return isLandscape
                      ? SliverPadding(
                          padding: EdgeInsets.symmetric(
                            vertical: 24.h,
                            horizontal: 16.w,
                          ),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              return AllahNameItem(
                                index: index + 1,
                                name: cubit.allahNames[index].text,
                              );
                            }, childCount: cubit.allahNames.length),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.h,
                                  crossAxisSpacing: 16.w,
                                ),
                          ),
                        )
                      : SliverPadding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 16.w,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: AllahNameList(cubit: cubit),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
