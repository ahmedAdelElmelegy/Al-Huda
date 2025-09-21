import 'dart:async';
import 'dart:io';
import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:al_huda/core/func/internet_dialog.dart';
import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/ayat.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/qran/presentation/manager/ayat/ayat_cubit.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayat_app_bar.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayat_buttom_nav_bar.dart';
import 'package:al_huda/feature/qran/presentation/widgets/ayat_soura_name_frame.dart';
import 'package:al_huda/feature/qran/presentation/widgets/remove_basmalla.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

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
  int? _currentlyPlayingAyah;
  final AudioPlayer _audioPlayer = AudioPlayer();
  StreamSubscription<PlayerState>? _playerStateSubscription;
  bool _isPlaying = false;
  int _currentAyahIndex = 0;
  final ScrollController _scrollController = ScrollController();
  double _fontSize = 16;
  PageController? pageController;

  @override
  void initState() {
    if (!widget.isFromHome!) {
      updateAyat(widget.surahData?.number ?? widget.index);
    }
    _setupAudioPlayerListeners();
    SharedPrefServices.getDoubleValue(Constants.qranFontSize).then((value) {
      setState(() {
        _fontSize = value ?? 16;
      });
    });
    pageController = PageController(initialPage: widget.index);
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
  int? number;
  updateAyat(int surahNumber) async {
    final cubit = context.read<AyatCubit>();
    cubit.ayatList.clear();

    readerName = await SharedPrefServices.getValue(Constants.reader);
    final reader = Constants.quranReader.firstWhere(
      (element) => element.url == readerName,
      orElse: () => Constants.quranReader.first,
    );
    setState(() {
      number = reader.number;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AyatCubit>().getAyat(
        surahNumber,
        readerName ?? AppURL.readerName,
      );
    });
  }

  void _scrollPage() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + 20,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> playAyahAudio(int ayahNumber) async {
    try {
      final cubit = context.read<AyatCubit>();

      final ayah = cubit.ayatList.firstWhere(
        (a) => a.numberInSurah == ayahNumber,
      );

      final globalAyahNumber = ayah.number;

      //  download link
      final url =
          "https://cdn.islamic.network/quran/audio/$number/${readerName ?? AppURL.readerName}/$globalAyahNumber.mp3";

      //  store path
      final dir = await getApplicationDocumentsDirectory();
      final filePath =
          "${dir.path}/ayah_${globalAyahNumber}_${readerName ?? AppURL.readerName}.mp3";

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
        (a) => a.numberInSurah == ayahNumber,
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
        _currentAyahIndex++;
      });
      _scrollPage();
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          onPageChanged: (index) {
            updateAyat(widget.surahList?[index].number ?? 0);
          },
          controller: pageController,
          itemCount: widget.surahList?.length ?? 0,
          itemBuilder: (context, index) {
            return BlocBuilder<AyatCubit, AyatState>(
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
                if (state is AyatError) {
                  if (state.failure.errMessage.contains(
                    "No internet connection",
                  )) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      internetDialog(
                        context,
                        onPressed: () {
                          cubit.getAyat(
                            widget.surahData?.number ?? widget.index,
                            readerName ?? AppURL.readerName,
                          );
                          pop();
                        },
                      );
                    });
                  }
                }

                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        verticalSpace(16),
                        AyatAppBar(
                          surahData:
                              widget.surahList?[index] ?? widget.surahData!,
                        ),
                        verticalSpace(24),
                        AyatSouraNameFrame(
                          surahData:
                              widget.surahList?[index] ?? widget.surahData!,
                        ),
                        verticalSpace(12),
                        if (basmala != null)
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 200.w),
                            child: Image.asset(AppImages.basmala),
                          ),
                        verticalSpace(12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: List.generate(ayatList.length, (
                                  index,
                                ) {
                                  final ayah = ayatList[index];
                                  final isPlaying =
                                      _currentlyPlayingAyah ==
                                      ayah.numberInSurah;

                                  return TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${ayah.text} ",
                                        style: TextSTyle.f16UthmanicHafs1Primary
                                            .copyWith(
                                              height: 2.2,
                                              fontSize: _fontSize.sp,
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
                                              fontSize: _fontSize.sp,
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
                            // ...QranServices.buildPageSeparators(cubit.ayatList),
                          ],
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

      bottomNavigationBar: AnimatedSwitcher(
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,

        duration: const Duration(milliseconds: 1000),
        transitionBuilder: (child, animation) {
          return SizeTransition(
            sizeFactor: animation,
            axis: Axis.vertical,
            child: child,
          );
        },
        child: _isPlaying
            ? AyatButtomNavBar(
                playPreviousAyah: _playPreviousAyah,
                playPauseAyah: _playPauseAyah,
                playNextAyah: _playNextAyah,
                isPlaying: _isPlaying,
              )
            : const SizedBox(),
      ),
    );
  }
}
