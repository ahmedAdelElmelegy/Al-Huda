import 'package:flutter/material.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:al_huda/core/di/injection.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/services.dart';
import '../manager/hadith_cubit.dart';

class HadithListScreen extends StatelessWidget {
  final String bookId;
  final String bookName;

  const HadithListScreen({
    super.key,
    required this.bookId,
    required this.bookName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<HadithCubit>()..getHadiths(bookId, reset: true),
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? ColorManager.backgroundDark
            : ColorManager.background,
        appBar: AppBar(
          title: Text(
            bookName,
            style: TextStyle(
              fontFamily: 'SSTArabicMedium',
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: ColorManager.primary,
          elevation: 4,
          shadowColor: ColorManager.primary.withValues(alpha: 0.5),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20.sp),
            onPressed: () => Navigator.pop(context),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
          ),
        ),
        body: const HadithListBody(),
      ),
    );
  }
}

class HadithListBody extends StatefulWidget {
  const HadithListBody({super.key});

  @override
  State<HadithListBody> createState() => _HadithListBodyState();
}

class _HadithListBodyState extends State<HadithListBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<HadithCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HadithCubit, HadithState>(
      builder: (context, state) {
        if (state is HadithLoading) {
          return const Center(
            child: CircularProgressIndicator(color: ColorManager.primary),
          );
        } else if (state is HadithLoaded) {
          if (state.hadiths.isEmpty) {
            return Center(
              child: Text(
                'no_items_found'.tr(),
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 16.sp,
                  color: ColorManager.textLight,
                ),
              ),
            );
          }
          return ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
            itemCount: state.hadiths.length + (state.hasReachedMax ? 0 : 1),
            itemBuilder: (context, index) {
              if (index >= state.hadiths.length) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: const CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                  ),
                );
              }
              final hadith = state.hadiths[index];
              return _StaggeredListItem(
                index: index,
                child: _buildHadithCard(context, hadith),
              );
            },
          );
        } else if (state is HadithError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'cannot_load_hadith'.tr(),
                  style: TextStyle(
                    fontFamily: 'SSTArabicMedium',
                    fontSize: 16.sp,
                    color: ColorManager.textHigh,
                  ),
                ),
                verticalSpace(16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () => context.read<HadithCubit>().loadMore(),
                  child: Text('retry'.tr()),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildHadithCard(BuildContext context, hadith) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Hadith ID Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '# ${hadith.id}',
                  style: TextStyle(
                    fontFamily: 'SSTArabicMedium',
                    fontSize: 13.sp,
                    color: ColorManager.primary,
                  ),
                ),
              ),
              // Copy Button Hub
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.content_copy_rounded,
                    color: ColorManager.primary.withValues(alpha: 0.7),
                    size: 18.sp,
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: hadith.hadithArabic));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('hadith_copied'.tr()),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: ColorManager.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          verticalSpace(20),
          Text(
            hadith.hadithArabic,
            style: TextStyle(
              fontFamily: 'AmiriBold',
              fontSize: 19.sp,
              color: isDark ? Colors.white.withValues(alpha: 0.9) : ColorManager.textHigh,
              height: 1.8,
            ),
            textAlign: TextAlign.right,
          ),
          if (hadith.chapterName != null && hadith.chapterName!.isNotEmpty) ...[
            verticalSpace(20),
            Divider(color: ColorManager.primary.withValues(alpha: 0.1)),
            verticalSpace(12),
            Row(
              children: [
                Icon(Icons.bookmark_outline_rounded,
                    color: ColorManager.primary.withValues(alpha: 0.5), size: 14.sp),
                horizontalSpace(8),
                Expanded(
                  child: Text(
                    hadith.chapterName!,
                    style: TextStyle(
                      fontFamily: 'SSTArabicRoman',
                      fontSize: 12.sp,
                      color: ColorManager.primary.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _StaggeredListItem extends StatelessWidget {
  final int index;
  final Widget child;

  const _StaggeredListItem({required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
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
