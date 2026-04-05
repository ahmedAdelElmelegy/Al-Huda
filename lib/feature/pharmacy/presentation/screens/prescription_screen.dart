import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/pharmacy/data/model/mood_prescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionScreen extends StatelessWidget {
  final MoodPrescription prescription;

  const PrescriptionScreen({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? ColorManager.backgroundDark
          : ColorManager.background,
      appBar: AppBar(
        title: Text(
          "رووشته السكينة",
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStateCard(context),
            verticalSpace(32),
            _buildPrescriptionSection(
              context: context,
              title: "آية تزيح عنك ${prescription.moodName}",
              content: prescription.verseText,
              subtitle: prescription.verseSource,
              icon: Icons.menu_book_rounded,
              color: const Color(0xFF4CAF50),
              isAyah: true,
            ),
            verticalSpace(20),
            _buildPrescriptionSection(
              context: context,
              title: "دعاء يريح قلبك",
              content: prescription.dua,
              icon: Icons.front_hand_rounded,
              color: const Color(0xFFFFB300),
            ),
            verticalSpace(20),
            _buildPrescriptionSection(
              context: context,
              title: "خطة الشفاء (العمل)",
              content: prescription.action,
              icon: Icons.checklist_rounded,
              color: ColorManager.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateCard(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: prescription.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: prescription.color.withValues(alpha: 0.15),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: prescription.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              prescription.icon,
              color: prescription.color,
              size: 32.sp,
            ),
          ),
          horizontalSpace(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "بما أنك تشعر بـ",
                  style: TextStyle(
                    fontFamily: 'SSTArabicRoman',
                    fontSize: 13.sp,
                    color: ColorManager.textLight,
                  ),
                ),
                Text(
                  prescription.moodName,
                  style: TextStyle(
                    fontFamily: 'SSTArabicMedium',
                    fontSize: 24.sp,
                    color: prescription.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionSection({
    required BuildContext context,
    required String title,
    required String content,
    String? subtitle,
    required IconData icon,
    required Color color,
    bool isAyah = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: color.withValues(alpha: 0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: color, size: 18.sp),
              ),
              horizontalSpace(12),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 15.sp,
                  color: color,
                ),
              ),
            ],
          ),
          verticalSpace(20),
          Text(
            content,
            style: TextStyle(
              fontFamily: isAyah || title.contains("دعاء")
                  ? 'AmiriBold'
                  : 'SSTArabicRoman',
              fontSize: isAyah || title.contains("دعاء") ? 20.sp : 15.sp,
              height: 1.6,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.95)
                  : ColorManager.textHigh,
            ),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            verticalSpace(16),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'SSTArabicRoman',
                    fontSize: 12.sp,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
