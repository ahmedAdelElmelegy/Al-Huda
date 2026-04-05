import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/library/data/model/library_models.dart';
import 'package:al_huda/feature/library/presentation/manager/library_cubit.dart';
import 'package:al_huda/feature/library/presentation/manager/library_state.dart';
import 'package:al_huda/feature/library/presentation/screens/articles_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibraryScreen extends StatefulWidget {
  final List<CategoryModel>? subCategories;
  final String title;

  const LibraryScreen({
    super.key,
    this.subCategories,
    this.title = "المكتبة الإسلامية",
  });

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.subCategories == null) {
      context.read<LibraryCubit>().loadCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? ColorManager.backgroundDark
          : ColorManager.background,
      appBar: AppBar(
        title: Text(
          widget.title,
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
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
        ),
      ),
      body: widget.subCategories != null
          ? _buildCategoryList(widget.subCategories!)
          : BlocBuilder<LibraryCubit, LibraryState>(
              builder: (context, state) {
                if (state is LibraryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                  );
                } else if (state is LibraryCategoriesLoaded) {
                  return _buildCategoryList(state.categories);
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
              },
            ),
    );
  }

  Widget _buildCategoryList(List<CategoryModel> categories) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 40.h),
      itemCount: categories.length + 2, // +2 for Prophet stories and Sira
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildSpecialCategoryCard(
            title: "قصص الأنبياء",
            icon: Icons.auto_stories_rounded,
            color: Colors.amber[700]!,
            onTap: () {
              context.read<LibraryCubit>().loadProphetArticles();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArticlesListScreen(),
                ),
              );
            },
          );
        } else if (index == 1) {
          return _buildSpecialCategoryCard(
            title: "السيرة النبوية",
            icon: Icons.history_edu_rounded,
            color: ColorManager.primary,
            onTap: () {
              context.read<LibraryCubit>().loadSieraArticles();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArticlesListScreen(),
                ),
              );
            },
          );
        }

        final category = categories[index - 2];
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
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
              vertical: 8.h,
            ),
            title: Text(
              category.title,
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 16.sp,
                color: isDark ? Colors.white : ColorManager.textHigh,
              ),
            ),
            subtitle: category.description != null
                ? Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      category.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'SSTArabicRoman',
                        fontSize: 12.sp,
                        color: ColorManager.textLight,
                      ),
                    ),
                  )
                : null,
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: ColorManager.primary.withValues(alpha: 0.4),
            ),
            onTap: () {
              if (category.subCategories != null &&
                  category.subCategories!.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LibraryScreen(
                      subCategories: category.subCategories,
                      title: category.title,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: ColorManager.primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    content: const Text(
                      "هذه التصنيفات ستتطلب اتصالا بالإنترنت في الإصدارات القادمة",
                      style: TextStyle(fontFamily: 'SSTArabicRoman'),
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildSpecialCategoryCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1.5),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        leading: Container(
          width: 52.w,
          height: 52.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 24.sp),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'SSTArabicMedium',
            fontSize: 18.sp,
            color: isDark ? Colors.white : ColorManager.textHigh,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14.sp,
            color: color,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
