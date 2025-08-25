import 'dart:async';

import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/feature/radio/data/model/radio_data.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
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
  Duration duration = Duration.zero; // الطول الكلي
  Duration position = Duration.zero; // الوقت الحالي
  double volume = 1.0; // الصوت (من 0 → 1)
  // subscriptions
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
    // لما الصوت يخلص
  }

  @override
  void didUpdateWidget(covariant RadioReaderAudio oldWidget) {
    super.didUpdateWidget(oldWidget);

    // لو الـ URL اتغير من القديم للجديد
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
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Cannot play audio: $e')));
      }
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                changeRadioRight(widget.radioData);
              },
              child: SvgIcon(assetName: AppIcons.skipRight),
            ),
            horizontalSpace(24),
            InkWell(
              onTap: () {
                togglePlayPause(widget.radioData.url!, false);
              },
              child: Container(
                width: 60,
                height: 60,
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
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 40.sp,
                  color: ColorManager.white,
                ),
              ),
            ),
            horizontalSpace(24),
            InkWell(
              onTap: () {
                changeRadioLeft(widget.radioData);
              },
              child: SvgIcon(assetName: AppIcons.skipLeft),
            ),
          ],
        ),

        verticalSpace(20),

        // شريط الوقت
        // Slider(
        //   value: position.inSeconds.toDouble(),
        //   min: 0,
        //   max: 0,
        //   onChanged: (value) async {
        //     // final newPosition = Duration(seconds: value.toInt());
        //     // await audioPlayer.seek(newPosition);
        //   },
        // ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Divider(
            color: ColorManager.primaryText2,
            height: 5.h,
            thickness: 2.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(formatTime(position)), Text(formatTime(duration))],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.volume_down, color: ColorManager.primaryText2),
            Slider(
              value: volume,
              min: 0,
              max: 1,
              onChanged: (value) {
                setState(() => volume = value);
                audioPlayer.setVolume(value);
              },
            ),
            Icon(Icons.volume_up, color: ColorManager.primaryText2),
          ],
        ),
      ],
    );
  }
}
