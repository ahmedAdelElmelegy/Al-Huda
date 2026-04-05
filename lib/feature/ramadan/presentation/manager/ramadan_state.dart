import '../../data/model/ramadan_model.dart';

abstract class RamadanState {}

class RamadanInitial extends RamadanState {}

class RamadanLoading extends RamadanState {}

class RamadanLoaded extends RamadanState {
  final RamadanData data;
  final int selectedDay;
  final int fastingDays;
  final Set<int> completedTasks;
  final double progressPercent;
  final String imsak;
  final String iftar;

  RamadanLoaded({
    required this.data,
    required this.selectedDay,
    required this.fastingDays,
    required this.completedTasks,
    required this.progressPercent,
    required this.imsak,
    required this.iftar,
  });
}

class RamadanError extends RamadanState {
  final String message;
  RamadanError(this.message);
}
