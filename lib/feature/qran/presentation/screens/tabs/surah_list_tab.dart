import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/qran/presentation/manager/Surah/qran_cubit.dart';
import 'package:al_huda/feature/qran/presentation/screens/ayat_screen.dart';
import 'package:al_huda/feature/qran/presentation/widgets/sura_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SurahListTab extends StatelessWidget {
  const SurahListTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return BlocBuilder<QranCubit, QranState>(
      builder: (context, state) {
        if (state is QranLoading) {
          return const LoadingListView();
        }
        final cubit = context.read<QranCubit>();
        List<SurahData> surahList = cubit.searchList.isNotEmpty
            ? cubit.searchList
            : cubit.surahList;

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Search & Hero Section ──────────────────────────────
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    _StaggeredItem(
                      index: 0,
                      child: _GlassSearchBar(onChanged: cubit.searchSurah),
                    ),
                    verticalSpace(16),
                    _StaggeredItem(
                      index: 1,
                      child: _LastReadCard(isDark: isDark),
                    ),
                    verticalSpace(24),
                  ],
                ),
              ),
            ),

            // ── Surah List ─────────────────────────────────────────
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return _StaggeredItem(
                  index: index + 2, // Offset by header items
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AyatScreen(
                            index: index,
                            surahData: surahList[index],
                            surahList: surahList,
                          )),
                        );
                        SharedPrefServices.setValue(
                          '${surahList[index].number}_${surahList[index].name}',
                          Constants.lastQuranSuraAndAyah,
                        );
                      },
                      child: SurahItem(
                        surahData: surahList[index],
                        isEven: index.isEven,
                        isDark: isDark,
                      ),
                    ),
                  ),
                );
              }, childCount: surahList.length),
            ),
            SliverToBoxAdapter(child: verticalSpace(40)),
          ],
        );
      },
    );
  }
}

// ─── Glass Search Bar ────────────────────────────────────────────────────────

class _GlassSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const _GlassSearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? ColorManager.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(
          fontFamily: 'SSTArabicRoman',
          fontSize: 14.sp,
          color: isDark ? Colors.white : ColorManager.textHigh,
        ),
        decoration: InputDecoration(
          hintText: 'search_for_surah'.tr(),
          hintStyle: TextStyle(
            fontFamily: 'SSTArabicRoman',
            fontSize: 14.sp,
            color: ColorManager.textLight.withValues(alpha: 0.6),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Icon(
              Icons.search_rounded,
              color: ColorManager.primary.withValues(alpha: 0.5),
              size: 20.sp,
            ),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
      ),
    );
  }
}

// ─── Last Read Card ───────────────────────────────────────────────────────────

class _LastReadCard extends StatelessWidget {
  final bool isDark;
  const _LastReadCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: SharedPrefServices.getValue(Constants.lastQuranSuraAndAyah),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }
        final parts = snapshot.data!.split('_');
        final surahName = parts.length > 1 ? parts[1] : snapshot.data!;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorManager.primary,
                ColorManager.primary.withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.r), // Premium 24r-32r curve
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Subtle Decorative Pattern Overlay
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  Icons.menu_book_rounded,
                  size: 100.sp,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.r),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.bookmark_rounded,
                        color: Colors.white,
                        size: 22.sp,
                      ),
                    ),
                    horizontalSpace(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'last_read'.tr(),
                            style: TextStyle(
                              fontFamily: 'SSTArabicRoman',
                              fontSize: 12.sp,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          verticalSpace(4),
                          Text(
                            surahName,
                            style: TextStyle(
                              fontFamily: 'AmiriBold', // Religious context
                              fontSize: 18.sp,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'continue'.tr(),
                        style: TextStyle(
                          fontFamily: 'SSTArabicMedium',
                          fontSize: 12.sp,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StaggeredItem extends StatelessWidget {
  final int index;
  final Widget child;

  const _StaggeredItem({required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 60)),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
