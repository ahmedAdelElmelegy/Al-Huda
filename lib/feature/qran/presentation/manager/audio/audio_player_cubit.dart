import 'dart:async';
import 'dart:io';

import 'package:al_huda/feature/qran/data/model/ayat_model/ayat.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  StreamSubscription<PlayerState>? _playerStateSubscription;

  List<Ayah> _ayatList = [];
  int? _readerNumber;
  String? _readerUrlName;

  AudioPlayerCubit() : super(const AudioPlayerState()) {
    _setupAudioPlayerListeners();
  }

  void init(List<Ayah> ayatList, int readerNumber, String readerUrlName) {
    _ayatList = List.from(ayatList);
    _readerNumber = readerNumber;
    _readerUrlName = readerUrlName;
  }

  void _setupAudioPlayerListeners() {
    _playerStateSubscription = _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        _handlePlaybackCompleted();
      }
    });
  }

  void _handlePlaybackCompleted() {
    if (state.repeatMode == RepeatMode.repeatAyah) {
      if (state.currentlyPlayingAyah != null) {
        playAyahAudio(state.currentlyPlayingAyah!);
      }
    } else {
      _playNextAyah();
    }
  }

  Future<void> playAyahAudio(int ayahNumberInSurah) async {
    try {
      if (_ayatList.isEmpty) return;

      emit(state.copyWith(isLoading: true, clearError: true));

      final ayah = _ayatList.firstWhere((a) => a.numberInSurah == ayahNumberInSurah);
      final globalAyahNumber = ayah.number;

      final url = "https://cdn.islamic.network/quran/audio/$_readerNumber/$_readerUrlName/$globalAyahNumber.mp3";
      
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/ayah_${globalAyahNumber}_$_readerUrlName.mp3";

      String audioSource;
      if (File(filePath).existsSync()) {
        audioSource = filePath;
      } else {
        await Dio().download(url, filePath);
        audioSource = filePath;
      }

      final newIndex = _ayatList.indexWhere((a) => a.numberInSurah == ayahNumberInSurah);

      await _audioPlayer.stop();
      await _audioPlayer.setPlaybackRate(state.playbackSpeed);
      await _audioPlayer.play(DeviceFileSource(audioSource));

      emit(state.copyWith(
        currentlyPlayingAyah: ayahNumberInSurah,
        currentAyahIndex: newIndex,
        isPlaying: true,
        isLoading: false,
      ));
    } catch (e) {
      debugPrint("Error playing ayah audio: $e");
      emit(state.copyWith(
        clearCurrentlyPlaying: true,
        isPlaying: false,
        isLoading: false,
        errorMessage: "Failed to play audio",
      ));
    }
  }

  void playPauseAyah() {
    if (state.isPlaying) {
      _audioPlayer.pause();
      emit(state.copyWith(isPlaying: false));
    } else {
      if (_ayatList.isNotEmpty) {
        if (state.currentlyPlayingAyah != null) {
          _audioPlayer.resume();
          emit(state.copyWith(isPlaying: true));
        } else {
          // Play from beginning if not started
          final ayah = _ayatList[0];
          playAyahAudio(ayah.numberInSurah);
        }
      }
    }
  }

  void _playNextAyah() {
    if (state.currentAyahIndex < _ayatList.length - 1) {
      final nextAyah = _ayatList[state.currentAyahIndex + 1];
      playAyahAudio(nextAyah.numberInSurah);
    } else {
      if (state.repeatMode == RepeatMode.repeatSurah) {
        final firstAyah = _ayatList[0];
        playAyahAudio(firstAyah.numberInSurah);
      } else {
        stopAudio();
      }
    }
  }

  void playNext() {
    _playNextAyah();
  }

  void playPrevious() {
    if (state.currentAyahIndex > 0) {
      final previousAyah = _ayatList[state.currentAyahIndex - 1];
      playAyahAudio(previousAyah.numberInSurah);
    }
  }

  void stopAudio() {
    _audioPlayer.stop();
    emit(state.copyWith(
      isPlaying: false,
      clearCurrentlyPlaying: true,
      currentAyahIndex: 0,
    ));
  }

  Future<void> setPlaybackSpeed(double speed) async {
    await _audioPlayer.setPlaybackRate(speed);
    emit(state.copyWith(playbackSpeed: speed));
  }

  void toggleRepeatMode() {
    RepeatMode nextMode;
    switch (state.repeatMode) {
      case RepeatMode.off:
        nextMode = RepeatMode.repeatSurah;
        break;
      case RepeatMode.repeatSurah:
        nextMode = RepeatMode.repeatAyah;
        break;
      case RepeatMode.repeatAyah:
        nextMode = RepeatMode.off;
        break;
    }
    emit(state.copyWith(repeatMode: nextMode));
  }

  @override
  Future<void> close() {
    _playerStateSubscription?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }
}
