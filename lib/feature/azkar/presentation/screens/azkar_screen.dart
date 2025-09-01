import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/custom_bg_app_bar.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/azkar/presentation/manager/cubit/azkar_cubit.dart';
import 'package:al_huda/feature/azkar/presentation/screens/azkar_detail_screen.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/azkar_item.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              collapsedHeight: 150.h,
              flexibleSpace: CustomBgAppBar(
                bgImage: AppImages.azkarBg,
                logoImage: AppImages.sunB,
              ),
              automaticallyImplyLeading: false,
            ),

            BlocBuilder<AzkarCubit, AzkarState>(
              builder: (context, state) {
                final azkarCategories = context
                    .read<AzkarCubit>()
                    .azkarCategories;
                if (state is AzkarLoading) {
                  return SliverToBoxAdapter(child: LoadingListView());
                } else if (state is AzkarError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'error'.tr(),
                        style: TextSTyle.f16AmiriBoldPrimary,
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return GestureDetector(
                        onTap: () {
                          push(
                            AzkarDetailScreen(
                              zikrName: azkarCategories[index].name,
                              zikr: azkarCategories[index].azkar,
                              index: index,
                            ),
                          );
                        },
                        child: AzkarItem(name: azkarCategories[index].name),
                      );
                    }, childCount: azkarCategories.length),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
