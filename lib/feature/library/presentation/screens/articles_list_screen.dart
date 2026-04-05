import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/library/presentation/manager/library_cubit.dart';
import 'package:al_huda/feature/library/presentation/manager/library_state.dart';
import 'package:al_huda/feature/library/presentation/screens/article_content_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticlesListScreen extends StatelessWidget {
  const ArticlesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<LibraryCubit, LibraryState>(
      builder: (context, state) {
        String title = "المقالات";
        if (state is LibraryArticlesLoaded) {
          title = state.title;
        }

        return Scaffold(
          backgroundColor: isDark
              ? ColorManager.backgroundDark
              : ColorManager.background,
          appBar: AppBar(
            title: Text(
              title,
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16.r),
              ),
            ),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, LibraryState state) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (state is LibraryLoading) {
      return const Center(
        child: CircularProgressIndicator(color: ColorManager.primary),
      );
    } else if (state is LibraryArticlesLoaded) {
      return ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 40.h),
        itemCount: state.articles.length,
        separatorBuilder: (context, index) => verticalSpace(16),
        itemBuilder: (context, index) {
          final article = state.articles[index];
          return Container(
            decoration: BoxDecoration(
              color: isDark ? ColorManager.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(32.r),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.primary.withValues(alpha: 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: ColorManager.primary.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 12.h,
              ),
              title: Text(
                article.title,
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 16.sp,
                  color: isDark ? Colors.white : ColorManager.textHigh,
                  height: 1.2,
                ),
              ),
              subtitle: article.description != null
                  ? Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        article.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'SSTArabicRoman',
                          fontSize: 12.sp,
                          color: ColorManager.textLight,
                          height: 1.4,
                        ),
                      ),
                    )
                  : null,
              trailing: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chrome_reader_mode_outlined,
                  color: ColorManager.primary,
                  size: 18.sp,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ArticleContentScreen(article: article),
                  ),
                );
              },
            ),
          );
        },
      );
    } else if (state is LibraryError) {
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
    return const SizedBox.shrink();
  }
}

SizedBox verticalSpace(double height) => SizedBox(height: height.h);
