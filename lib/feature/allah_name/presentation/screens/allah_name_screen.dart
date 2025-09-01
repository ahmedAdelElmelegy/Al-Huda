import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/custom_bg_app_bar.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/allah_name/presentation/manager/cubit/allah_name_cubit.dart';
import 'package:al_huda/feature/allah_name/presentation/widgets/allah_name_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllahNameScreen extends StatelessWidget {
  const AllahNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500.w),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  collapsedHeight: 170.h,
                  flexibleSpace: CustomBgAppBar(
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
                    return SliverPadding(
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
      ),
    );
  }
}
