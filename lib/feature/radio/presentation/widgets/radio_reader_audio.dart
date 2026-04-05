import 'dart:async';

import 'package:al_huda/feature/radio/data/model/radio_data.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioReaderAudio extends StatefulWidget {
  final RadioData radioData;
  final Function(RadioData) onRadioChangeRight;
  final Function(RadioData) onRadioChangeLeft;
  final List<RadioData> radioList;
  const RadioReaderAudio({
    super.key,
    required this.radioData,
    required this.radioList,
    required this.onRadioChangeRight,
    required this.onRadioChangeLeft,
  });

  @override
  State<RadioReaderAudio> createState() => _RadioReaderAudioState();
}

class _RadioReaderAudioState extends State<RadioReaderAudio> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  double volume = 1.0;
  StreamSubscription? durationSub;
  StreamSubscription? positionSub;
  StreamSubscription? completeSub;
  @override
  void initState() {
    super.initState();

    togglePlayPause(widget.radioData.url!, false);

    durationSub = audioPlayer.onDurationChanged.listen((d) {
      if (!mounted) return;
      setState(() => duration = d);
    });

    positionSub = audioPlayer.onPositionChanged.listen((p) {
      if (!mounted) return;
      setState(() => position = p);
    });

    completeSub = audioPlayer.onPlayerComplete.listen((event) {
      if (!mounted) return;
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });
  }

  @override
  void didUpdateWidget(covariant RadioReaderAudio oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.radioData.url != widget.radioData.url) {
      togglePlayPause(widget.radioData.url!, true);
    }
  }

  @override
  void dispose() {
    durationSub?.cancel();
    positionSub?.cancel();
    completeSub?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> togglePlayPause(String audioUrl, bool choseInteral) async {
    try {
      if (choseInteral) {
        await audioPlayer.play(UrlSource(audioUrl));
        setState(() {
          isPlaying = true;
        });
      } else {
        if (isPlaying) {
          await audioPlayer.pause();
          setState(() => isPlaying = false);
        } else {
          await audioPlayer.play(UrlSource(audioUrl));
          setState(() => isPlaying = true);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changeRadioRight(RadioData current) {
    final list = widget.radioList;
    final currentIndex = list.indexOf(current);
    if (currentIndex < list.length - 1) {
      widget.onRadioChangeRight(list[currentIndex + 1]);
    }
  }

  void changeRadioLeft(RadioData current) {
    final list = widget.radioList;
    final currentIndex = list.indexOf(current);
    if (currentIndex > 0) {
      widget.onRadioChangeLeft(list[currentIndex - 1]);
    }
  }

  String formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => changeRadioLeft(widget.radioData),
              icon: Icon(
                Icons.skip_previous_rounded,
                color: ColorManager.primary.withValues(alpha: 0.6),
                size: 32.sp,
              ),
            ),
            horizontalSpace(24),
            InkWell(
              onTap: () => togglePlayPause(widget.radioData.url!, false),
              child: Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.primary,
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  size: 40.sp,
                  color: Colors.white,
                ),
              ),
            ),
            horizontalSpace(24),
            IconButton(
              onPressed: () => changeRadioRight(widget.radioData),
              icon: Icon(
                Icons.skip_next_rounded,
                color: ColorManager.primary.withValues(alpha: 0.6),
                size: 32.sp,
              ),
            ),
          ],
        ),
        verticalSpace(32),
        // Time Indicators
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: [
              Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: duration.inSeconds > 0
                      ? (position.inSeconds / duration.inSeconds).clamp(0, 1)
                      : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ),
              verticalSpace(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatTime(position),
                    style: TextStyle(
                      fontFamily: 'SSTArabicRoman',
                      fontSize: 12.sp,
                      color: ColorManager.textLight.withValues(alpha: 0.7),
                    ),
                  ),
                  Text(
                    formatTime(duration),
                    style: TextStyle(
                      fontFamily: 'SSTArabicRoman',
                      fontSize: 12.sp,
                      color: ColorManager.textLight.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        verticalSpace(24),
        // Volume Control
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Row(
            children: [
              Icon(
                Icons.volume_mute_rounded,
                color: ColorManager.primary.withValues(alpha: 0.4),
                size: 20.sp,
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 2.h,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
                    activeTrackColor: ColorManager.primary,
                    inactiveTrackColor: ColorManager.primary.withValues(
                      alpha: 0.1,
                    ),
                    thumbColor: ColorManager.primary,
                  ),
                  child: Slider(
                    value: volume,
                    min: 0,
                    max: 1,
                    onChanged: (value) {
                      setState(() => volume = value);
                      audioPlayer.setVolume(value);
                    },
                  ),
                ),
              ),
              Icon(
                Icons.volume_up_rounded,
                color: ColorManager.primary.withValues(alpha: 0.4),
                size: 20.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
