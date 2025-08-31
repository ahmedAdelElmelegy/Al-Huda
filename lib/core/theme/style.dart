import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextSTyle {
  static String reg = 'CairoRegular';
  static String bold = 'CairoBold';
  static String semiBold = 'CairoSemiBold';
  static String medium = 'CairoMedium';
  static String light = 'CairoLight';
  static String amiriReg = 'Amiri';
  static String amiriBold = 'AmiriBold';
  static String amiriItalic = 'AmiriItalic';
  static String amiriBoldItalic = 'AmiriBoldItalic';
  static String uthmanicHafs1 = 'UthmanicHafs1';
  static String sSTArabicMedium = 'SSTArabicMedium';
  static String sSTArabicRoman = 'SSTArabicRoman';
  static String sSTArabicLight = 'SSTArabicLight';

  static TextStyle f12CairoRegGrey = TextStyle(
    color: ColorManager.gray,
    fontSize: 12.sp,
    fontFamily: reg,
  );
  static TextStyle f12CairoBoldGrey = TextStyle(
    color: ColorManager.gray,
    fontSize: 12.sp,
    fontFamily: bold,
  );
  static TextStyle f16CairoMediumBlack = TextStyle(
    color: ColorManager.black,
    fontSize: 16.sp,
    fontFamily: medium,
  );
  static TextStyle f20CairoLightGrey = TextStyle(
    color: ColorManager.gray,
    fontSize: 20.sp,
    fontFamily: light,
  );
  // 16

  static TextStyle f16CairoLightPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 16.sp,
    fontFamily: light,
  );
  static TextStyle f16CairoRegBlack = TextStyle(
    color: ColorManager.black,
    fontSize: 16.sp,
    fontFamily: reg,
  );
  static TextStyle f16CairoSemiBoldWhite = TextStyle(
    color: ColorManager.white,
    fontSize: 16.sp,
    fontFamily: semiBold,
  );
  static TextStyle f10CairoRegPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 10.sp,
    fontFamily: reg,
  );
  // 18
  static TextStyle f18CairoMediumBlack = TextStyle(
    color: ColorManager.black,
    fontSize: 18.sp,
    fontFamily: medium,
  );
  static TextStyle f18CairoSemiBoldPrimary = TextStyle(
    color: ColorManager.primaryText,
    fontSize: 18.sp,
    fontFamily: semiBold,
  );
  static TextStyle f18CairoBoldWhite = TextStyle(
    color: ColorManager.white,
    fontSize: 18.sp,
    fontFamily: bold,
  );
  static TextStyle f24CairoSemiBoldPrimary = TextStyle(
    color: ColorManager.primaryText,
    fontSize: 24.sp,
    fontFamily: semiBold,
  );
  static TextStyle f36CairoBoldWhite = TextStyle(
    color: ColorManager.white,
    fontSize: 36.sp,
    fontFamily: bold,
  );
  // 14
  static TextStyle f14CairoLightPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 14.sp,
    fontFamily: light,
  );
  static TextStyle f14CairoRegularPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 14.sp,
    fontFamily: reg,
  );
  static TextStyle f14CairoBoldPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 14.sp,
    fontFamily: bold,
  );
  static TextStyle f14CairoSemiBoldPrimary = TextStyle(
    color: ColorManager.primary,
    fontSize: 14.sp,
    fontFamily: semiBold,
  );
  static TextStyle f14CairoMeduimPrimary = TextStyle(
    color: ColorManager.primaryText,
    fontSize: 14.sp,
    fontFamily: light,
  );
  // 8
  static TextStyle f8CairoLightPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 8.sp,
    fontFamily: light,
  );
  //

  // white
  static TextStyle f14CairoLightWhite = TextStyle(
    color: ColorManager.white,
    fontSize: 14.sp,
    fontFamily: light,
  );

  static TextStyle f8CairoSemiBoldWhite = TextStyle(
    color: ColorManager.white,
    fontSize: 8.sp,
    fontFamily: semiBold,
  );
  static TextStyle f12CairoSemiBoldWhite = TextStyle(
    color: ColorManager.white,
    fontSize: 12.sp,
    fontFamily: semiBold,
  );
  static TextStyle f12CairoSemiBoldPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 12.sp,
    fontFamily: semiBold,
  );
  // 36
  static TextStyle f36CairoSemiBoldPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 36.sp,
    fontFamily: semiBold,
  );
  // for amiri
  static TextStyle f12AmiriRegPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 12.sp,
    height: 1.6,
    fontFamily: amiriReg,
  );
  // 10
  static TextStyle f10AmiriRegPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 10.sp,
    fontFamily: amiriReg,
  );
  static TextStyle f16AmiriRegPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 16.sp,
    fontFamily: amiriReg,
  );
  static TextStyle f16AmiriBoldPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 16.sp,
    fontFamily: amiriBold,
  );
  static TextStyle f20AmiriBoldWhite = TextStyle(
    color: ColorManager.white,
    fontSize: 20.sp,
    fontFamily: bold,
  );
  // for uthmanic
  static TextStyle f16UthmanicHafs1Primary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 16.sp,
    fontFamily: uthmanicHafs1,
  );

  // 16,18 for new font
  static TextStyle f16SSTArabicMediumPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 16.sp,
    fontFamily: sSTArabicMedium,
  );
  static TextStyle f16SSTArabicMediumBlack = TextStyle(
    color: ColorManager.black,
    fontSize: 16.sp,
    fontFamily: sSTArabicMedium,
  );
  static TextStyle f16SSTArabicRegBlack = TextStyle(
    color: ColorManager.black,
    fontSize: 16.sp,
    fontFamily: sSTArabicRoman,
  );
  static TextStyle f16SSTArabicLightPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 16.sp,
    fontFamily: sSTArabicLight,
  );
  static TextStyle f18SSTArabicMediumPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 18.sp,
    fontFamily: sSTArabicMedium,
  );
  static TextStyle f18SSTArabicRegPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 18.sp,
    fontFamily: sSTArabicRoman,
  );
  // 24
  static TextStyle f24SSTArabicMediumPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 24.sp,
    fontFamily: sSTArabicMedium,
  );
  // 14
  static TextStyle f14SSTArabicMediumPrimary = TextStyle(
    color: ColorManager.primary,
    fontSize: 14.sp,
    fontFamily: sSTArabicMedium,
  );
}
