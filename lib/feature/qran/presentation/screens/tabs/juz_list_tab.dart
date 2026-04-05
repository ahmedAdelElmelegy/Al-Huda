import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/qran/presentation/manager/Surah/qran_cubit.dart';
import 'package:al_huda/feature/qran/presentation/screens/ayat_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JuzListTab extends StatelessWidget {
  const JuzListTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Simplistic Juz mapping logic. A full mapping will require specific juz index mapping.
    // For demonstration of the tab layout and advanced UI, we will provide an elegant placeholder 
    // or standard Grid selection.
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 1.0,
        ),
        itemCount: 30, // 30 Juzs
        itemBuilder: (context, index) {
          final juzNumber = index + 1;
          
          return Container(
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
              border: Border.all(
                color: ColorManager.primary.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  // Advanced mapping for Juz requires knowing which Surah starts the Juz.
                  // Defaulting to the first Surah for now.
                  final surahList = context.read<QranCubit>().surahList;
                  if (surahList.isNotEmpty) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AyatScreen(index: 0, surahData: surahList.first, surahList: surahList)));
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$juzNumber',
                      style: TextSTyle.f24CairoSemiBoldPrimary.copyWith(
                        color: ColorManager.primary,
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      'juz'.tr(),
                      style: TextSTyle.f12CairoSemiBoldPrimary.copyWith(
                        color: ColorManager.gray,
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
