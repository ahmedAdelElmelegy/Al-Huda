import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/quiz/presentation/manager/quiz_cubit.dart';
import 'package:al_huda/feature/quiz/presentation/manager/quiz_state.dart';
import 'package:al_huda/feature/quiz/presentation/screens/widgets/quiz_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? ColorManager.backgroundDark
          : ColorManager.background,
      appBar: AppBar(
        title: Text(
          "اختبار إسلامي",
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
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          } else if (state is QuizError) {
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
          } else if (state is QuizLoaded) {
            return _buildQuizBody(context, state);
          } else if (state is QuizCompleted) {
            return QuizResultCard(
              score: state.score,
              total: state.total,
              onRestart: () => context.read<QuizCubit>().restartQuiz(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildQuizBody(BuildContext context, QuizLoaded state) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final question = state.questions[state.currentIndex];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "السؤال ${state.currentIndex + 1} من ${state.questions.length}",
                style: TextStyle(
                  fontFamily: 'SSTArabicRoman',
                  fontSize: 13.sp,
                  color: ColorManager.textLight,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  "النتيجة: ${state.score}",
                  style: TextStyle(
                    fontFamily: 'SSTArabicMedium',
                    fontSize: 13.sp,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(16),
          // Luxury Progress Bar
          Container(
            height: 8.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (state.currentIndex + 1) / state.questions.length,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(32.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.primary.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          verticalSpace(40),

          // Question Card
          Container(
            padding: EdgeInsets.all(32.r),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(32.r),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.primary.withValues(alpha: 0.08),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
              border: Border.all(
                color: ColorManager.primary.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Text(
              question.question,
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 20.sp,
                color: isDark ? Colors.white : ColorManager.textHigh,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          verticalSpace(40),

          // Options
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                return QuizOptionCard(
                  option: question.options[index],
                  isSelected: state.selectedAnswer == index,
                  isCorrect: index == question.correctIndex,
                  answered: state.answered,
                  onTap: () => context.read<QuizCubit>().selectAnswer(index),
                );
              },
            ),
          ),

          // Next Button
          if (state.answered)
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: ElevatedButton(
                onPressed: () => context.read<QuizCubit>().nextQuestion(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  elevation: 8,
                  shadowColor: ColorManager.primary.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  state.currentIndex < state.questions.length - 1
                      ? "السؤال التالي"
                      : "عرض النتيجة",
                  style: TextStyle(
                    fontFamily: 'SSTArabicMedium',
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
