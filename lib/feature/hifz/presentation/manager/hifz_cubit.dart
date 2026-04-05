import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/qran_services.dart';
import '../../data/repo/hifz_repo.dart';
import 'hifz_state.dart';

class HifzCubit extends Cubit<HifzState> {
  final HifzRepo _hifzRepo;
  final QranServices _qranServices;

  HifzCubit(this._hifzRepo, this._qranServices) : super(HifzInitial());

  Future<void> loadHifzData() async {
    emit(HifzLoading());
    try {
      final memorized = _hifzRepo.getMemorizedVerses(-1); // Get all
      final due = _hifzRepo.getDueVerses();

      final surahList = await _qranServices.getAllSouraFromHive();
      final totalAyahsCount = surahList.fold<int>(
        0,
        (sum, surah) => sum + (surah.numberOfAyahs ?? 0),
      );

      final Map<int, double> surahProgressMap = {};
      for (var verse in memorized) {
        if (!surahProgressMap.containsKey(verse.surahIndex)) {
          final surah = surahList.firstWhere(
            (s) => s.number == verse.surahIndex,
          );
          surahProgressMap[verse.surahIndex] = _hifzRepo.getSurahProgress(
            verse.surahIndex,
            surah.numberOfAyahs ?? 0,
          );
        }
      }

      final progress = _hifzRepo.getTotalProgress(
        totalAyahsCount > 0 ? totalAyahsCount : 6236,
      );

      emit(
        HifzLoaded(
          memorizedVerses: memorized,
          dueReviews: due,
          totalProgress: progress,
          surahProgress: surahProgressMap,
          surahList: surahList,
        ),
      );
    } catch (e) {
      emit(HifzError(e.toString()));
    }
  }

  Future<void> markAsMemorized(int surah, int ayah) async {
    await _hifzRepo.markAsMemorized(surah, ayah);
    await loadHifzData();
  }

  Future<void> markAsReviewed(int surah, int ayah, bool success) async {
    await _hifzRepo.markAsReviewed(surah, ayah, success);
    await loadHifzData();
  }
}
