import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/qran/presentation/manager/Surah/qran_cubit.dart';
import 'package:al_huda/feature/qran/presentation/screens/ayat_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeLastSurah extends StatefulWidget {
  const HomeLastSurah({super.key});

  @override
  State<HomeLastSurah> createState() => _HomeLastSurahState();
}

class _HomeLastSurahState extends State<HomeLastSurah> {
  String? surahNumber;
  String? surahName;
  @override
  void initState() {
    super.initState();
    SharedPrefServices.getValue(Constants.lastQuranSuraAndAyah).then((value) {
      if (!mounted) return;
      setState(() {
        surahNumber = value?.split('_').first;
        surahName = value?.split('_').last;
      });
    });
    if (surahNumber != null) {
      getCurrentAytaSuaah(int.parse(surahNumber!));
    }
  }

  SurahData getCurrentAytaSuaah(int surahNumber) {
    return context.read<QranCubit>().surahList.firstWhere(
      (element) => element.number == surahNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'last_read'.tr(),
          style: TextSTyle.f14SSTArabicBoldWhite.copyWith(
            color: ColorManager.white,
          ),
        ),
        verticalSpace(10),
        Text(
          surahName ?? 'elfateha'.tr(),
          style: TextSTyle.f20AmiriBoldWhite.copyWith(
            color: ColorManager.white,
          ),
        ),
        verticalSpace(10),
        GestureDetector(
          onTap: () {
            push(
              AyatScreen(
                isFromHome: true,
                index: int.parse(surahNumber ?? '1'),
                surahData: getCurrentAytaSuaah(int.parse(surahNumber ?? '1')),
                surahList: [getCurrentAytaSuaah(int.parse(surahNumber ?? '1'))],
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: ColorManager.white,
            ),
            child: Text(
              'continue'.tr(),
              style: TextSTyle.f14CairoBoldPrimary.copyWith(
                color: ColorManager.primary2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
