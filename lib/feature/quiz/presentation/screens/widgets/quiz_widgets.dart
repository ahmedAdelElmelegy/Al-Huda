import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizOptionCard extends StatelessWidget {
  final String option;
  final bool isSelected;
  final bool isCorrect;
  final bool answered;
  final VoidCallback onTap;

  const QuizOptionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.answered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color borderColor = ColorManager.primary.withValues(alpha: 0.1);
    Color bgColor = isDark ? ColorManager.surfaceDark : Colors.white;
    isDark ? Colors.white70 : ColorManager.textHigh;

    if (answered) {
      if (isCorrect) {
        borderColor = Colors.green[400]!;
        bgColor = Colors.green.withValues(alpha: 0.08);
      } else if (isSelected) {
        borderColor = Colors.red[400]!;
        bgColor = Colors.red.withValues(alpha: 0.08);
      }
    } else if (isSelected) {
      borderColor = ColorManager.primary;
      bgColor = ColorManager.primary.withValues(alpha: 0.05);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 16.sp,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.9)
                      : ColorManager.textHigh,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            horizontalSpace(16),
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: 2),
                color: (answered && isCorrect)
                    ? Colors.green[400]
                    : (answered && isSelected
                          ? Colors.red[400]
                          : Colors.transparent),
              ),
              child: answered
                  ? Icon(
                      isCorrect
                          ? Icons.check_rounded
                          : (isSelected ? Icons.close_rounded : null),
                      size: 16.sp,
                      color: Colors.white,
                    )
                  : (isSelected
                        ? Center(
                            child: Container(
                              width: 12.w,
                              height: 12.w,
                              decoration: const BoxDecoration(
                                color: ColorManager.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizResultCard extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onRestart;

  const QuizResultCard({
    super.key,
    required this.score,
    required this.total,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    Theme.of(context).brightness == Brightness.dark;
    final percentage = (score / total * 100).round();
    String message = "أحسنت!";
    IconData icon = Icons.emoji_events_rounded;
    Color color = Colors.orange[400]!;

    if (percentage >= 90) {
      message = "ممتاز! بارك الله فيك";
      color = ColorManager.primary;
      icon = Icons.stars_rounded;
    } else if (percentage >= 70) {
      message = "جيد جداً! استمر في التعلم";
      color = Colors.teal[400]!;
      icon = Icons.thumb_up_rounded;
    } else if (percentage < 50) {
      message = "حاول مرة أخرى لتزيد معلوماتك";
      color = Colors.red[400]!;
      icon = Icons.refresh_rounded;
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(32.r),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 80.sp, color: color),
            ),
            verticalSpace(32),
            Text(
              message,
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 24.sp,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
