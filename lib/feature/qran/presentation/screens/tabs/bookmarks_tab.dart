import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/qran/presentation/manager/Surah/qran_cubit.dart';
import 'package:al_huda/feature/qran/presentation/manager/bookmark/bookmark_cubit.dart';
import 'package:al_huda/feature/qran/presentation/screens/ayat_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookmarksTab extends StatelessWidget {
  const BookmarksTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) {
        if (state is BookmarkLoading) {
          return const Center(child: CircularProgressIndicator(color: ColorManager.primary));
        }
        
        if (state is BookmarkLoaded) {
          final bookmarks = state.bookmarks;
          
          if (bookmarks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border_rounded, size: 64.sp, color: ColorManager.gray),
                  verticalSpace(16),
                  Text(
                    'no_bookmarks'.tr(),
                    style: TextSTyle.f16CairoMediumBlack.copyWith(
                      color: isDark ? Colors.white : ColorManager.textHigh,
                    ),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final bookmark = bookmarks[index];
                    final surahData = context.read<QranCubit>().surahList.firstWhere(
                      (s) => s.number == bookmark.surahNumber,
                    );
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
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
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16.r),
                          onTap: () {
                            final idx = context.read<QranCubit>().surahList.indexWhere(
                                (s) => s.number == bookmark.surahNumber);
                            if (idx != -1) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AyatScreen(
                                index: idx,
                                surahData: surahData,
                                surahList: context.read<QranCubit>().surahList,
                              )));
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${surahData.name} - ${'ayah'.tr()} ${bookmark.ayahNumber}',
                                      style: TextSTyle.f16CairoSemiBoldWhite.copyWith(
                                        color: ColorManager.primary,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete_outline_rounded, color: ColorManager.error, size: 20.sp),
                                      onPressed: () {
                                        context.read<BookmarkCubit>().removeBookmark(bookmark.id);
                                      },
                                    ),
                                  ],
                                ),
                                verticalSpace(8),
                                Text(
                                  bookmark.text,
                                  textAlign: TextAlign.right,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextSTyle.f16UthmanicHafs1Primary.copyWith(
                                    color: isDark ? Colors.white : ColorManager.textHigh,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }, childCount: bookmarks.length),
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(40)),
            ],
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }
}
