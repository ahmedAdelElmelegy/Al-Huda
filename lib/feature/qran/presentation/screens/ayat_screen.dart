import 'dart:async';

import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/qran_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/ayat.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/qran/presentation/manager/ayat/ayat_cubit.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayat_app_bar.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayat_soura_name_frame.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/gestures.dart';
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
  int? _currentlyPlayingAyah;
  final AudioPlayer _audioPlayer = AudioPlayer();
  StreamSubscription<PlayerState>? _playerStateSubscription;
  bool _isPlaying = false;
  int _currentAyahIndex = 0;

  @override
  void initState() {
    updateAyat(widget.surahData.number!);
    _setupAudioPlayerListeners();
    super.initState();
  }

  void _setupAudioPlayerListeners() {
    _playerStateSubscription = _audioPlayer.onPlayerStateChanged.listen((
      state,
    ) {
      if (state == PlayerState.completed) {
        _playNextAyah();
      }
    });
  }

  updateAyat(int surahNumber) async {
    String? readerName = await QranServices.getReaderName();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AyatCubit>().getAyat(
        surahNumber,
        readerName ?? AppURL.readerName,
      );
    });
  }

  Future<void> playAyahAudio(String url, int ayahNumber) async {
    try {
      final cubit = context.read<AyatCubit>();

      final newIndex = cubit.ayatList.indexWhere(
        (ayah) => ayah.numberInSurah == ayahNumber,
      );

      setState(() {
        _currentlyPlayingAyah = ayahNumber;
        _isPlaying = true;
        _currentAyahIndex = newIndex; // تحديث الفهرس فقط
      });

      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
    } catch (e) {
      debugPrint("Error playing ayah audio: $e");
      setState(() {
        _currentlyPlayingAyah = null;
        _isPlaying = false;
      });
    }
  }

  void _playPauseAyah() {
    final cubit = context.read<AyatCubit>();

    if (_isPlaying) {
      _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
        _currentlyPlayingAyah = null;
      });
    } else {
      if (cubit.ayatList.isNotEmpty &&
          _currentAyahIndex < cubit.ayatList.length) {
        final ayah = cubit.ayatList[_currentAyahIndex];
        playAyahAudio(ayah.audio, ayah.numberInSurah);
      }
    }
  }

  void _playNextAyah() {
    final cubit = context.read<AyatCubit>();

    if (_currentAyahIndex < cubit.ayatList.length - 1) {
      final nextAyah = cubit.ayatList[_currentAyahIndex + 1];

      setState(() {
        _currentAyahIndex++; // زيادة الفهرس مرة واحدة فقط
      });

      playAyahAudio(nextAyah.audio, nextAyah.numberInSurah);
    } else {
      setState(() {
        _isPlaying = false;
        _currentlyPlayingAyah = null;
      });
      _audioPlayer.stop();
    }
  }

  void _playPreviousAyah() {
    final cubit = context.read<AyatCubit>();

    if (_currentAyahIndex > 0) {
      final previousAyah = cubit.ayatList[_currentAyahIndex - 1];

      setState(() {
        _currentAyahIndex--; // تخفيض الفهرس مرة واحدة فقط
      });

      playAyahAudio(previousAyah.audio, previousAyah.numberInSurah);
    }
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                              final isPlaying =
                                  _currentlyPlayingAyah == ayah.numberInSurah;

                              return TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${ayah.text} ",
                                    style: TextSTyle.f16UthmanicHafs1Primary
                                        .copyWith(
                                          height: 2.2,
                                          fontSize: 20.sp,
                                          color: isPlaying
                                              ? ColorManager.primary
                                              : ColorManager.primaryText2,
                                          backgroundColor: isPlaying
                                              ? ColorManager.primaryBg
                                              : Colors.transparent,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (_isPlaying) {
                                          _audioPlayer.stop();
                                          setState(() {
                                            _isPlaying = false;
                                            _currentlyPlayingAyah = null;
                                          });
                                        }
                                        playAyahAudio(
                                          ayah.audio,
                                          ayah.numberInSurah,
                                        );
                                      },
                                  ),
                                  TextSpan(
                                    text:
                                        " ${ayah.numberInSurah.toString().replaceAllMapped(RegExp(r'\d'), (match) => '٠١٢٣٤٥٦٧٨٩'[int.parse(match[0]!)])} ",
                                    style: TextSTyle.f16UthmanicHafs1Primary
                                        .copyWith(
                                          fontSize: 16.sp,
                                          color: isPlaying
                                              ? ColorManager.primary
                                              : ColorManager.primaryText2,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (_isPlaying) {
                                          _audioPlayer.stop();
                                          setState(() {
                                            _isPlaying = false;
                                            _currentlyPlayingAyah = null;
                                          });
                                        }
                                        playAyahAudio(
                                          ayah.audio,
                                          ayah.numberInSurah,
                                        );
                                      },
                                  ),
                                ],
                              );
                            }),
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.justify,
                        ),
                        ..._buildPageSeparators(cubit.ayatList),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(color: ColorManager.primaryBg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: _playPreviousAyah,
                child: SvgIcon(
                  assetName: AppIcons.skipRight,
                  width: 16.sp,
                  height: 16.sp,
                ),
              ),
              horizontalSpace(24),
              InkWell(
                onTap: _playPauseAyah,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.primaryText2,
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.primaryText2.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 24.sp,
                    color: ColorManager.white,
                  ),
                ),
              ),
              horizontalSpace(24),
              InkWell(
                onTap: _playNextAyah,
                child: SvgIcon(
                  assetName: AppIcons.skipLeft,
                  width: 16.sp,
                  height: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageSeparators(List<Ayah> ayatList) {
    List<Widget> separators = [];
    for (int i = 0; i < ayatList.length - 1; i++) {
      final currentAyah = ayatList[i];
      final nextAyah = ayatList[i + 1];

      if (currentAyah.page != nextAyah.page) {
        separators.add(
          Column(
            children: [
              verticalSpace(12),
              Divider(color: ColorManager.gray, thickness: 1),
              Text(
                "الصفحة ${currentAyah.page}",
                style: TextSTyle.f16AmiriBoldPrimary.copyWith(
                  fontSize: 18.sp,
                  color: ColorManager.primaryText2,
                ),
              ),
              verticalSpace(12),
            ],
          ),
        );
      }
    }

    if (ayatList.isNotEmpty) {
      separators.add(
        Column(
          children: [
            verticalSpace(12),
            Divider(color: ColorManager.gray, thickness: 1),
            Text(
              "الصفحة ${ayatList.last.page}",
              style: TextSTyle.f16AmiriBoldPrimary.copyWith(
                fontSize: 18.sp,
                color: ColorManager.primaryText2,
              ),
            ),
            verticalSpace(12),
          ],
        ),
      );
    }

    return separators;
  }
}
