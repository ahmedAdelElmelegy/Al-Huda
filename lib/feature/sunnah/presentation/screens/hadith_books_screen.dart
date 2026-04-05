import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'hadith_list_screen.dart';

class HadithBooksScreen extends StatelessWidget {
  const HadithBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> books = [
      {'id': 'sahih-bukhari', 'name': 'elbokhary'.tr()},
      {'id': 'sahih-muslim', 'name': 'moslem'.tr()},
      {'id': 'al-tirmidhi', 'name': 'altormozy'.tr()},
      {'id': 'sunan-ibn-majah', 'name': 'ebnMaga'.tr()},
      {'id': 'sunan-abu-dawood', 'name': 'aboDawood'.tr()},
    ];

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? ColorManager.backgroundDark
          : ColorManager.background,
      appBar: AppBar(
        title: Text(
          'hadith_books_title'.tr(),
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
          onPressed: () => Navigator.pop(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
        ),
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 40.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.95, // Slightly taller for elegant typography
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return _StaggeredGridItem(
            index: index,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HadithListScreen(
                      bookId: book['id']!,
                      bookName: book['name']!,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? ColorManager.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(32.r),
                  gradient: isDark 
                      ? null 
                      : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            ColorManager.primary.withValues(alpha: 0.02),
                          ],
                        ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.primary.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Book Icon Hub
                    Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorManager.primary.withValues(alpha: 0.05),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.auto_stories_rounded,
                        color: ColorManager.primary,
                        size: 28.sp,
                      ),
                    ),
                    verticalSpace(16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        book['name']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SSTArabicMedium',
                          fontSize: 15.sp,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.95)
                              : ColorManager.textHigh,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StaggeredGridItem extends StatelessWidget {
  final int index;
  final Widget child;

  const _StaggeredGridItem({required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 100)),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
