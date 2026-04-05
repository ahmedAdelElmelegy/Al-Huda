import 'package:al_huda/core/helper/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors.dart';
import '../../data/model/hajj_model.dart';
import '../manager/hajj_cubit.dart';
import '../manager/hajj_state.dart';

class HajjUmrahScreen extends StatefulWidget {
  const HajjUmrahScreen({super.key});

  @override
  State<HajjUmrahScreen> createState() => _HajjUmrahScreenState();
}

class _HajjUmrahScreenState extends State<HajjUmrahScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<HajjCubit>().loadHajjUmrahData();
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? ColorManager.backgroundDark
          : ColorManager.background,
      appBar: AppBar(
        title: Text(
          'hajj_umrah_guide'.tr(),
          style: TextStyle(
            fontFamily: 'SSTArabicMedium',
            fontSize: 18.sp,
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
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3.h,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: TextStyle(fontFamily: 'SSTArabicMedium', fontSize: 14.sp),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'SSTArabicRoman',
            fontSize: 14.sp,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
          tabs: [
            Tab(text: 'hajj_tab'.tr()),
            Tab(text: 'umrah_tab'.tr()),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
        ),
      ),
      body: BlocBuilder<HajjCubit, HajjState>(
        builder: (context, state) {
          if (state is HajjLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          } else if (state is HajjLoaded) {
            return TabBarView(
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              children: [
                _buildStepsList(state.data.hajj, isArabic),
                _buildStepsList(state.data.umrah, isArabic),
              ],
            );
          } else if (state is HajjError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 16.sp,
                  color: ColorManager.textHigh,
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () => _showDuasBottomSheet(context, isArabic),
          label: Text(
            'duas_label'.tr(),
            style: TextStyle(
              fontFamily: 'SSTArabicMedium',
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
          icon: Icon(
            Icons.auto_stories_rounded,
            color: Colors.white,
            size: 20.sp,
          ),
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
      ),
    );
  }

  Widget _buildStepsList(List<HajjStep> steps, bool isArabic) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.w, 32.h, 20.w, 100.h),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.primary.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      step.step.toString(),
                      style: TextStyle(
                        fontFamily: 'SSTArabicMedium',
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorManager.primary,
                          ColorManager.primary.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            horizontalSpace(20),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 24.h),
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: isDark ? ColorManager.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(32.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.primary.withValues(alpha: 0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.getTitle(isArabic),
                      style: TextStyle(
                        fontFamily: 'SSTArabicMedium',
                        fontSize: 18.sp,
                        color: ColorManager.primary,
                      ),
                    ),
                    verticalSpace(10),
                    Text(
                      step.getDescription(isArabic),
                      style: TextStyle(
                        fontFamily: 'SSTArabicRoman',
                        fontSize: 14.sp,
                        color: isDark ? Colors.white70 : ColorManager.textHigh,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDuasBottomSheet(BuildContext context, bool isArabic) {
    final state = context.read<HajjCubit>().state;
    if (state is! HajjLoaded) return;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? ColorManager.surfaceDark : Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                verticalSpace(12),
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                verticalSpace(24),
                Text(
                  'duas_label'.tr(),
                  style: TextStyle(
                    fontFamily: 'SSTArabicMedium',
                    fontSize: 20.sp,
                    color: ColorManager.primary,
                  ),
                ),
                verticalSpace(20),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 40.h),
                    itemCount: state.data.duas.length,
                    separatorBuilder: (context, index) => verticalSpace(16),
                    itemBuilder: (context, index) {
                      final dua = state.data.duas[index];
                      return Container(
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E2A28)
                              : ColorManager.background,
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                            color: ColorManager.primary.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4.w,
                                  height: 14.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                ),
                                horizontalSpace(10),
                                Text(
                                  dua.getTitle(isArabic),
                                  style: TextStyle(
                                    fontFamily: 'SSTArabicMedium',
                                    fontSize: 14.sp,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(16),
                            Text(
                              dua.getText(isArabic),
                              style: TextStyle(
                                fontFamily: 'Amiri-Bold',
                                fontSize: 20.sp,
                                color: isDark
                                    ? Colors.white
                                    : ColorManager.textHigh,
                                height: 1.8,
                              ),
                              textAlign: isArabic
                                  ? TextAlign.right
                                  : TextAlign.left,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
