import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/qran/presentation/manager/ayat/ayat_cubit.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayat_app_bar.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayat_soura_name_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AyatScreen extends StatefulWidget {
  final SurahData surahData;
  const AyatScreen({super.key, required this.surahData});

  @override
  State<AyatScreen> createState() => _AyatScreenState();
}

class _AyatScreenState extends State<AyatScreen> {
  @override
  void initState() {
    updateAyat(widget.surahData.number!);
    super.initState();
  }

  updateAyat(int surahNumber) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AyatCubit>().getAyat(surahNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SafeArea(
          child: BlocBuilder<AyatCubit, AyatState>(
            builder: (context, state) {
              final cubit = context.read<AyatCubit>();
              if (state is AyatLoading) {
                return const LoadingListView();
              }
              if (state is AyatError) {
                return Center(child: Text(state.message));
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      AyatAppBar(surahData: widget.surahData),
                      verticalSpace(24),
                      AyatSouraNameFrame(surahData: widget.surahData),
                      verticalSpace(24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: List.generate(cubit.ayatList.length, (
                                index,
                              ) {
                                final ayah = cubit.ayatList[index];
                                final ayahNumber = (index + 1)
                                    .toString()
                                    .replaceAllMapped(
                                      RegExp(r'\d'),
                                      (match) =>
                                          '٠١٢٣٤٥٦٧٨٩'[int.parse(match[0]!)],
                                    );

                                List<InlineSpan> spans = [];

                                spans.add(
                                  TextSpan(
                                    text: "${ayah.text} $ayahNumber ",
                                    style: TextSTyle.f16UthmanicHafs1Primary
                                        .copyWith(height: 2.2, fontSize: 20.sp),
                                  ),
                                );

                                final isLastAyahInPage =
                                    (index == cubit.ayatList.length - 1) ||
                                    (ayah.page !=
                                        cubit.ayatList[index + 1].page);

                                if (isLastAyahInPage) {
                                  spans.add(
                                    WidgetSpan(
                                      child: Column(
                                        children: [
                                          verticalSpace(12),
                                          Divider(
                                            color: ColorManager.gray,
                                            thickness: 1,
                                          ),
                                          Text(
                                            "الصفحة ${ayah.page}",
                                            style: TextSTyle.f16AmiriBoldPrimary
                                                .copyWith(
                                                  fontSize: 18.sp,
                                                  color:
                                                      ColorManager.primaryText2,
                                                ),
                                          ),
                                          verticalSpace(12),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                return TextSpan(children: spans);
                              }),
                            ),
                            textDirection: TextDirection.rtl,
                            softWrap: true,

                            textAlign:
                                TextAlign.start, // 👈 يوزع النص على عرض الشاشة
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
