part of 'audio_player_cubit.dart';

enum RepeatMode { off, repeatAyah, repeatSurah }

@immutable
class AudioPlayerState {
  final bool isPlaying;
  final int? currentlyPlayingAyah; // By numberInSurah
  final int currentAyahIndex;
  final RepeatMode repeatMode;
  final double playbackSpeed;
  final bool isLoading;
  final String? errorMessage;

  const AudioPlayerState({
    this.isPlaying = false,
    this.currentlyPlayingAyah,
    this.currentAyahIndex = 0,
    this.repeatMode = RepeatMode.off,
    this.playbackSpeed = 1.0,
    this.isLoading = false,
    this.errorMessage,
  });

  AudioPlayerState copyWith({
    bool? isPlaying,
    int? currentlyPlayingAyah,
    int? currentAyahIndex,
    RepeatMode? repeatMode,
    double? playbackSpeed,
    bool? isLoading,
    String? errorMessage,
    bool clearCurrentlyPlaying = false,
    bool clearError = false,
  }) {
    return AudioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentlyPlayingAyah: clearCurrentlyPlaying ? null : (currentlyPlayingAyah ?? this.currentlyPlayingAyah),
      currentAyahIndex: currentAyahIndex ?? this.currentAyahIndex,
      repeatMode: repeatMode ?? this.repeatMode,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
