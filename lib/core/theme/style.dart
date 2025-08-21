import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextSTyle {
  static String reg = 'CairoRegular';
  static String bold = 'CairoBold';
  static String semiBold = 'CairoSemiBold';
  static String medium = 'CairoMedium';
  static String light = 'CairoLight';

  static TextStyle f12CairoRegGrey = TextStyle(
    color: ColorManager.gray,
    fontSize: 12.sp,
    fontFamily: reg,
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
  // 36
  static TextStyle f36CairoSemiBoldPrimary = TextStyle(
    color: ColorManager.primaryText2,
    fontSize: 36.sp,
    fontFamily: semiBold,
  );
}
