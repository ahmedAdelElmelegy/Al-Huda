import 'dart:async';
import 'dart:io';
import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:al_huda/core/func/internet_dialog.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/qran_services.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/qran/presentation/manager/ayat/ayat_cubit.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayat_app_bar.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayat_buttom_nav_bar.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayat_soura_name_frame.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

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

  String? readerName;

  updateAyat(int surahNumber) async {
    readerName = await SharedPrefServices.getValue(Constants.reader);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AyatCubit>().getAyat(
        surahNumber,
        readerName ?? AppURL.readerName,
      );
    });
  }

  Future<void> playAyahAudio(int ayahNumber) async {
    try {
      final cubit = context.read<AyatCubit>();

      //  download link
      final url =
          "https://cdn.islamic.network/quran/audio/128/${readerName ?? AppURL.readerName}/$ayahNumber.mp3";

      //  store path
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/ayah_$ayahNumber.mp3";

      String audioSource;
      if (File(filePath).existsSync()) {
        // file in device
        audioSource = filePath;
      } else {
        // download file
        await Dio().download(url, filePath);
        audioSource = filePath;
      }

      final newIndex = cubit.ayatList.indexWhere(
        (ayah) => ayah.numberInSurah == ayahNumber,
      );

      setState(() {
        _currentlyPlayingAyah = ayahNumber;
        _isPlaying = true;
        _currentAyahIndex = newIndex;
      });

      await _audioPlayer.stop();
      await _audioPlayer.play(DeviceFileSource(audioSource));
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
        playAyahAudio(ayah.numberInSurah);
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

      playAyahAudio(nextAyah.numberInSurah);
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
        _currentAyahIndex--;
      });

      playAyahAudio(previousAyah.numberInSurah);
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
              if (state.failure.errMessage.contains("No internet connection")) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  internetDialog(
                    context,
                    onPressed: () {
                      cubit.getAyat(
                        widget.surahData.number!,
                        readerName ?? AppURL.readerName,
                      );
                      pop();
                    },
                  );
                });
              }
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    verticalSpace(16),
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
                                        playAyahAudio(ayah.numberInSurah);
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
                                        playAyahAudio(ayah.numberInSurah);
                                      },
                                  ),
                                ],
                              );
                            }),
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.justify,
                        ),
                        ...QranServices.buildPageSeparators(cubit.ayatList),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: AyatButtomNavBar(
        playPreviousAyah: _playPreviousAyah,
        playPauseAyah: _playPauseAyah,
        playNextAyah: _playNextAyah,
        isPlaying: _isPlaying,
      ),
    );
  }
}
