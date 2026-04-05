import '../../data/model/hajj_model.dart';

abstract class HajjState {}

class HajjInitial extends HajjState {}

class HajjLoading extends HajjState {}

class HajjLoaded extends HajjState {
  final HajjUmrahData data;
  HajjLoaded(this.data);
}

class HajjError extends HajjState {
  final String message;
  HajjError(this.message);
}
