import 'package:al_huda/core/func/internet_dialog.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/qran/presentation/manager/Surah/qran_cubit.dart';
import 'package:al_huda/feature/qran/presentation/screens/ayat_screen.dart';
import 'package:al_huda/feature/qran/presentation/widgets/sura_item.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SurahListView extends StatelessWidget {
  const SurahListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QranCubit, QranState>(
      builder: (context, state) {
        if (state is QranLoading) {
          return LoadingListView();
        }

        final cubit = context.read<QranCubit>();
        List<SurahData> surahList = cubit.searchList.isNotEmpty
            ? cubit.searchList
            : cubit.surahList;
        if (state is QranError) {
          if (state.failure.errMessage.contains("No internet connection")) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              internetDialog(
                context,
                onPressed: () {
                  cubit.fetchSurah();
                  pop();
                },
              );
            });
          }
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                onChanged: (value) {
                  cubit.searchSurah(value);
                },
                decoration: InputDecoration(
                  hintText: 'search_for_surah'.tr(),
                  hintStyle: TextSTyle.f14SSTArabicMediumPrimary.copyWith(
                    color: ColorManager.gray,
                  ),

                  enabledBorder: outlineBorder(color: ColorManager.gray),
                  focusedBorder: outlineBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
            verticalSpace(16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: surahList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    push(
                      AyatScreen(
                        index: index,
                        surahData: surahList[index],
                        surahList: surahList,
                      ),
                    );
                  },
                  child: SurahItem(surahData: surahList[index]),
                );
              },
            ),
          ],
        );
      },
    );
  }

  OutlineInputBorder outlineBorder({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? ColorManager.primaryText2),
      borderRadius: BorderRadius.circular(16.r),
    );
  }
}
