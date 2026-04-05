import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/library/data/model/library_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleContentScreen extends StatelessWidget {
  final ArticleModel article;

  const ArticleContentScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? ColorManager.backgroundDark
          : ColorManager.background,
      appBar: AppBar(
        title: Text(
          article.title,
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
        actions: [
          if (article.attachments != null && article.attachments!.isNotEmpty)
            IconButton(
              icon: const Icon(
                Icons.file_download_outlined,
                color: Colors.white,
              ),
              onPressed: () => _showAttachments(context),
            ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (article.description != null &&
                article.description!.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(32.r),
                  border: Border.all(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Text(
                  article.description!,
                  style: TextStyle(
                    fontFamily: 'SSTArabicMedium',
                    fontSize: 16.sp,
                    color: isDark ? Colors.white70 : ColorManager.textHigh,
                    height: 1.6,
                  ),
                ),
              ),
              verticalSpace(24),
            ],

            // Content Section
            Text(
              _stripHtmlIfNeeded(
                article.fullDescription ??
                    "لا يوجد محتوى متاح حالياً للمعاينة السريعة. يمكنك تحميل المرفقات أدناه.",
              ),
              style: TextStyle(
                fontFamily: 'SSTArabicRoman',
                fontSize: 15.sp,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.9)
                    : ColorManager.textHigh,
                height: 1.8,
              ),
            ),

            if (article.preparedBy != null &&
                article.preparedBy!.isNotEmpty) ...[
              verticalSpace(40),
              Divider(color: ColorManager.primary.withValues(alpha: 0.1)),
              verticalSpace(16),
              Row(
                children: [
                  Container(
                    width: 3.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  horizontalSpace(10),
                  Text(
                    "إعداد:",
                    style: TextStyle(
                      fontFamily: 'SSTArabicMedium',
                      fontSize: 14.sp,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
              verticalSpace(8),
              ...article.preparedBy!.map(
                (p) => Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    p.title,
                    style: TextStyle(
                      fontFamily: 'SSTArabicMedium',
                      fontSize: 16.sp,
                      color: isDark ? Colors.white70 : ColorManager.textHigh,
                    ),
                  ),
                ),
              ),
            ],

            if (article.attachments != null &&
                article.attachments!.isNotEmpty) ...[
              verticalSpace(40),
              Row(
                children: [
                  Container(
                    width: 3.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  horizontalSpace(10),
                  Text(
                    "المرفقات المتاحة:",
                    style: TextStyle(
                      fontFamily: 'SSTArabicMedium',
                      fontSize: 14.sp,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
              verticalSpace(16),
              ...article.attachments!.map(
                (a) => Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    color: isDark ? ColorManager.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: ColorManager.primary.withValues(alpha: 0.1),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 4.h,
                    ),
                    leading: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.picture_as_pdf_rounded,
                        color: Colors.red,
                        size: 20.sp,
                      ),
                    ),
                    title: Text(
                      a.description ?? article.title,
                      style: TextStyle(
                        fontFamily: 'SSTArabicMedium',
                        fontSize: 14.sp,
                        color: isDark ? Colors.white70 : ColorManager.textHigh,
                      ),
                    ),
                    subtitle: Text(
                      "${a.size ?? ''} - ${a.extensionType ?? 'PDF'}",
                      style: TextStyle(
                        fontFamily: 'SSTArabicRoman',
                        fontSize: 11.sp,
                        color: ColorManager.textLight,
                      ),
                    ),
                    trailing: Icon(
                      Icons.download_rounded,
                      color: ColorManager.primary,
                      size: 18.sp,
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: ColorManager.primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          content: Text(
                            "جاري فتح الرابط: ${a.url}",
                            style: const TextStyle(
                              fontFamily: 'SSTArabicRoman',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showAttachments(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? ColorManager.surfaceDark : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
              "المرفقات",
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 18.sp,
                color: ColorManager.primary,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(16),
            ...article.attachments!.map(
              (a) => ListTile(
                leading: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.link_rounded,
                    color: ColorManager.primary,
                    size: 18.sp,
                  ),
                ),
                title: Text(
                  a.description ?? "رابط خارجي",
                  style: TextStyle(
                    fontFamily: 'SSTArabicMedium',
                    fontSize: 14.sp,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
            verticalSpace(24),
          ],
        ),
      ),
    );
  }
}

SizedBox verticalSpace(double height) => SizedBox(height: height.h);
SizedBox horizontalSpace(double width) => SizedBox(width: width.w);

String _stripHtmlIfNeeded(String text) {
  // Very basic tag stripping for preview
  return text.replaceAll(RegExp(r'<[^>]*>|&nbsp;'), ' ');
}
