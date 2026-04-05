import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/allah_name/presentation/manager/cubit/allah_name_cubit.dart';
import 'package:al_huda/feature/allah_name/presentation/widgets/allah_name_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllahNameScreen extends StatelessWidget {
  const AllahNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final isLandscape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? ColorManager.backgroundDark
          : ColorManager.background,
      appBar: AppBar(
        title: Text(
          'allah_name'.tr(),
          style: TextStyle(
            fontFamily: 'SSTArabicMedium',
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.primary,
        elevation: 4,
        shadowColor: ColorManager.primary.withValues(alpha: 0.2),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20.sp,
          ),
          onPressed: () => pop(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
        ),
      ),
      body: BlocBuilder<AllahNameCubit, AllahNameState>(
        builder: (context, state) {
          final cubit = context.read<AllahNameCubit>();
          if (state is AllahNameLoading) {
            return const LoadingListView();
          } else if (state is AllahNameError) {
            return Center(
              child: Text(
                'error'.tr(),
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 16.sp,
                  color: ColorManager.primary,
                ),
              ),
            );
          }
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              verticalSpace(16),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return AllahNameItem(
                      index: index + 1,
                      name: cubit.allahNames[index].text,
                    );
                  }, childCount: cubit.allahNames.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 1.1, // Slightly wider for elegance
                  ),
                ),
              ),
              verticalSpace(40),
            ],
          );
        },
      ),
    );
  }
}
