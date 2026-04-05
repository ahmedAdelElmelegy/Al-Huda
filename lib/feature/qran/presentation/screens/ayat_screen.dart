import 'dart:async';

import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/ayat.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/qran/presentation/manager/audio/audio_player_cubit.dart';
import 'package:al_huda/feature/qran/presentation/manager/ayat/ayat_cubit.dart';
import 'package:al_huda/feature/qran/presentation/widgets/audio_player_bar.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayat_app_bar.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayah_action_sheet.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayat_soura_name_frame.dart';
import 'package:al_huda/feature/qran/presentation/widgets/remove_basmalla.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AyatScreen extends StatefulWidget {
  final SurahData? surahData;
  final bool? isFromHome;
  final List<SurahData>? surahList;
  final int index;

  const AyatScreen({
    super.key,
    this.surahData,
    this.surahList,
    required this.index,
    this.isFromHome = false,
  });

  @override
  State<AyatScreen> createState() => _AyatScreenState();
}

class _AyatScreenState extends State<AyatScreen> {
  final ScrollController _scrollController = ScrollController();
  double _fontSize = 16;
  PageController? pageController;
  int hidingLevel = 0; // 0: Show All, 1: Hide Endings, 2: Beginnings Only

  String? readerName;
  int? readerNumber;

  Future<void> _loadSettings() async {
    final value = await SharedPrefServices.getDoubleValue(Constants.qranFontSize) ?? 16.0;
    if (mounted) {
      setState(() {
        _fontSize = value;
      });
    }
  }

  @override
  void initState() {
    if (!widget.isFromHome!) {
      updateAyat(widget.surahData?.number ?? widget.index);
    }
    _loadSettings();
    pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  void _scrollPage(int currentAyahIndex) {
    if (_scrollController.hasClients) {
      // Small automatic scroll to keep reading in view
      _scrollController.animateTo(
        _scrollController.offset + 25,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> updateAyat(int surahNumber) async {
    final cubit = context.read<AyatCubit>();
    cubit.ayatList.clear();

    readerName = await SharedPrefServices.getValue(Constants.reader) ?? AppURL.readerName;
    final reader = Constants.quranReader.firstWhere(
      (element) => element.url == readerName,
      orElse: () => Constants.quranReader.first,
    );
    
    setState(() {
      readerNumber = reader.number;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getAyat(surahNumber, readerName!);
    });
  }

  void _onAyatLoaded(List<Ayah> ayatList) {
    if (readerNumber != null && readerName != null) {
      context.read<AudioPlayerCubit>().init(ayatList, readerNumber!, readerName!);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AudioPlayerCubit, AudioPlayerState>(
      listenWhen: (previous, current) =>
          previous.currentlyPlayingAyah != current.currentlyPlayingAyah &&
          current.currentlyPlayingAyah != null,
      listener: (context, state) {
        _scrollPage(state.currentAyahIndex);
      },
      child: Scaffold(
        body: SafeArea(
          child: PageView.builder(
            onPageChanged: (index) {
              context.read<AudioPlayerCubit>().stopAudio();
              updateAyat(widget.surahList?[index].number ?? 0);
            },
            controller: pageController,
            itemCount: widget.surahList?.length ?? 0,
            itemBuilder: (context, index) {
              return BlocConsumer<AyatCubit, AyatState>(
                listener: (context, state) {
                  if (state is AyatSuccess) {
                    _onAyatLoaded(context.read<AyatCubit>().ayatList);
                  }
                },
                builder: (context, state) {
                  final cubit = context.read<AyatCubit>();
                  List<Ayah> ayatList = List.from(cubit.ayatList);
                  String? basmala;
                  if (ayatList.isNotEmpty &&
                      ayatList.first.text.trim().startsWith(
                        'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                      )) {
                    ayatList[0] = ayatList.first.copyWith(
                      text: ayatList.first.text.removeBasmala(),
                    );
                    basmala = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';
                  }

                  if (state is AyatLoading) {
                    return const LoadingListView();
                  }

                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          verticalSpace(16),
                          AyatAppBar(
                            surahData: widget.surahList?[index] ?? widget.surahData!,
                            onSettingsClosed: _loadSettings,
                          ),
                          verticalSpace(24),
                          AyatSouraNameFrame(
                            surahData: widget.surahList?[index] ?? widget.surahData!,
                          ),
                          verticalSpace(24),

                          if (basmala != null)
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 200.w),
                              child: Image.asset(AppImages.basmala),
                            ),
                          verticalSpace(12),
                          BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
                            builder: (context, audioState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: List.generate(ayatList.length, (i) {
                                        final ayah = ayatList[i];
                                        final isPlaying = audioState.currentlyPlayingAyah == ayah.numberInSurah;

                                        String displayRepo = ayah.text;
                                        if (hidingLevel == 1) {
                                          List<String> words = displayRepo.split(' ');
                                          if (words.length > 3) {
                                            displayRepo = "${words.take(3).join(' ')} ...";
                                          }
                                        } else if (hidingLevel == 2) {
                                          displayRepo = "${displayRepo.split(' ').first} ...";
                                        }

                                        return TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "$displayRepo ",
                                              style: TextSTyle.f16UthmanicHafs1Primary.copyWith(
                                                height: 2.2,
                                                fontSize: _fontSize.sp,
                                                color: isPlaying
                                                    ? ColorManager.primary
                                                    : ColorManager.primaryText2,
                                                backgroundColor: isPlaying
                                                    ? ColorManager.primary.withValues(alpha: 0.1)
                                                    : Colors.transparent,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  context.read<AudioPlayerCubit>().playAyahAudio(ayah.numberInSurah);
                                                },
                                            ),
                                            TextSpan(
                                              text: " ${ayah.numberInSurah.toString().replaceAllMapped(RegExp(r'\d'), (match) => '٠١٢٣٤٥٦٧٨٩'[int.parse(match[0]!)])} ",
                                              style: TextSTyle.f16UthmanicHafs1Primary.copyWith(
                                                fontSize: _fontSize.sp,
                                                color: isPlaying
                                                    ? ColorManager.primary
                                                    : ColorManager.primaryText2,
                                              ),
                                              recognizer: LongPressGestureRecognizer()
                                                ..onLongPress = () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    backgroundColor: Colors.transparent,
                                                    isScrollControlled: true,
                                                    builder: (context) => AyahActionSheet(
                                                      ayah: ayah,
                                                      surahData: widget.surahList?[index] ?? widget.surahData!,
                                                      cleanAyahText: ayah.text,
                                                    ),
                                                  );
                                                },
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  verticalSpace(80), // Space for floating AudioPlayerBar
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BlocBuilder<AyatCubit, AyatState>(
          builder: (context, state) {
            return AudioPlayerBar(totalAyahs: context.read<AyatCubit>().ayatList.length);
          },
        ),
      ),
    );
  }
}
