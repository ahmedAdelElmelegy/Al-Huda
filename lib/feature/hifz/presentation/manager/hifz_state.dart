import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import '../../data/model/hifz_model.dart';

abstract class HifzState {}

class HifzInitial extends HifzState {}

class HifzLoading extends HifzState {}

class HifzLoaded extends HifzState {
  final List<HifzVerse> memorizedVerses;
  final List<HifzVerse> dueReviews;
  final double totalProgress;
  final Map<int, double> surahProgress;
  final List<SurahData> surahList;

  HifzLoaded({
    required this.memorizedVerses,
    required this.dueReviews,
    required this.totalProgress,
    required this.surahProgress,
    required this.surahList,
  });
}

class HifzError extends HifzState {
  final String message;
  HifzError(this.message);
}
