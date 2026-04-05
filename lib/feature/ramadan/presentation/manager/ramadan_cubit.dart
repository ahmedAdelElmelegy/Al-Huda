import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/prayer_services.dart';
import '../../data/repo/ramadan_repo.dart';
import 'ramadan_state.dart';

class RamadanCubit extends Cubit<RamadanState> {
  final RamadanRepo _ramadanRepo;
  final PrayerServices _prayerServices = PrayerServices();

  RamadanCubit(this._ramadanRepo) : super(RamadanInitial());

  Future<void> loadRamadanData({int day = 1}) async {
    emit(RamadanLoading());
    try {
      final data = await _ramadanRepo.getRamadanData();
      final fastingDays = _ramadanRepo.getFastingDaysCount();
      final completed = _ramadanRepo.getCompletedTasksForDay(day);

      // Calculate Imsakiya
      final prayerTimes = await _prayerServices.getPrayerTimes();
      final imsakTime = prayerTimes.fajr.subtract(const Duration(minutes: 10));
      final iftarTime = prayerTimes.maghrib;

      final timeFormat = DateFormat('hh:mm a');

      emit(
        RamadanLoaded(
          data: data,
          selectedDay: day,
          fastingDays: fastingDays,
          completedTasks: completed,
          progressPercent: completed.length / data.dailyActions.length,
          imsak: timeFormat.format(imsakTime),
          iftar: timeFormat.format(iftarTime),
        ),
      );
    } catch (e) {
      emit(RamadanError(e.toString()));
    }
  }

  void selectDay(int day) {
    if (state is RamadanLoaded) {
      final currentState = state as RamadanLoaded;
      final completed = _ramadanRepo.getCompletedTasksForDay(day);
      emit(
        RamadanLoaded(
          data: currentState.data,
          selectedDay: day,
          fastingDays: currentState.fastingDays,
          completedTasks: completed,
          progressPercent:
              completed.length / currentState.data.dailyActions.length,
          imsak: currentState.imsak,
          iftar: currentState.iftar,
        ),
      );
    }
  }

  Future<void> toggleAction(int actionId) async {
    if (state is RamadanLoaded) {
      final currentState = state as RamadanLoaded;
      await _ramadanRepo.toggleTask(currentState.selectedDay, actionId);

      final completed = _ramadanRepo.getCompletedTasksForDay(
        currentState.selectedDay,
      );
      final fastingDays = _ramadanRepo.getFastingDaysCount();

      emit(
        RamadanLoaded(
          data: currentState.data,
          selectedDay: currentState.selectedDay,
          fastingDays: fastingDays,
          completedTasks: completed,
          progressPercent:
              completed.length / currentState.data.dailyActions.length,
          imsak: currentState.imsak,
          iftar: currentState.iftar,
        ),
      );
    }
  }
}
