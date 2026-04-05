import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/sunnah_habit.dart';
import '../../data/repo/sunnah_repo.dart';

abstract class SunnahState {}
class SunnahInitial extends SunnahState {}
class SunnahLoading extends SunnahState {}
class SunnahLoaded extends SunnahState {
  final List<SunnahHabit> habits;
  SunnahLoaded(this.habits);
}
class SunnahError extends SunnahState {
  final String message;
  SunnahError(this.message);
}

class SunnahCubit extends Cubit<SunnahState> {
  final SunnahRepo repo;
  SunnahCubit(this.repo) : super(SunnahInitial());

  Future<void> getHabits() async {
    emit(SunnahLoading());
    try {
      final habits = await repo.getSunnahHabits();
      emit(SunnahLoaded(habits));
    } catch (e) {
      emit(SunnahError(e.toString()));
    }
  }

  Future<void> toggleHabit(String habitId) async {
    try {
      await repo.toggleHabitCompletion(habitId);
      final habits = await repo.getSunnahHabits();
      emit(SunnahLoaded(habits));
    } catch (e) {
      emit(SunnahError(e.toString()));
    }
  }
}
