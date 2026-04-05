import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/pharmacy/presentation/manager/pharmacy_cubit.dart';
import 'package:al_huda/feature/pharmacy/presentation/manager/pharmacy_state.dart';
import 'package:al_huda/feature/pharmacy/presentation/screens/prescription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? ColorManager.backgroundDark
          : ColorManager.background,
      appBar: AppBar(
        title: Text(
          "صيدلية المسلم",
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
      body: BlocBuilder<PharmacyCubit, PharmacyState>(
        builder: (context, state) {
          if (state is PharmacyInitial) {
            context.read<PharmacyCubit>().loadPharmacy();
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          }
          if (state is PharmacyLoaded) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
                  child: Column(
                    children: [
                      Text(
                        "كيف تجد قلبك اليوم؟",
                        style: TextStyle(
                          fontFamily: 'SSTArabicMedium',
                          fontSize: 24.sp,
                          color: ColorManager.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace(12),
                      Text(
                        "اختر حالتك لنصف لك العلاج من كتاب الله وسنة نبيه",
                        style: TextStyle(
                          fontFamily: 'SSTArabicRoman',
                          fontSize: 13.sp,
                          color: ColorManager.textLight,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 40.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 1.05,
                    ),
                    itemCount: state.prescriptions.length,
                    itemBuilder: (context, index) {
                      final item = state.prescriptions[index];
                      return _buildMoodCard(context, item);
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildMoodCard(BuildContext context, dynamic item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrescriptionScreen(prescription: item),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? ColorManager.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: item.color.withValues(alpha: 0.12),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: item.color.withValues(alpha: 0.1),
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, color: item.color, size: 28.r),
            ),
            verticalSpace(16),
            Text(
              item.moodName,
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 15.sp,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.9)
                    : ColorManager.textHigh,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
