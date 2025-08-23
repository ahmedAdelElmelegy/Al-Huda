part of 'tasbeh_cubit.dart';

@immutable
sealed class TasbehState {}

final class TasbehInitial extends TasbehState {}

final class TasbehLoading extends TasbehState {}

final class TasbehSuccess extends TasbehState {
  final List<TasbehModel> tasbehList;
  TasbehSuccess({required this.tasbehList});
}

final class TasbehFailure extends TasbehState {
  final String message;
  TasbehFailure({required this.message});
}

final class TasbehAddLoading extends TasbehState {}

final class TasbehAddSuccess extends TasbehState {}

final class TasbehAddFailure extends TasbehState {
  final String message;
  TasbehAddFailure({required this.message});
}

// increment

final class TasbehIncrementSuccess extends TasbehState {}

final class TasbehGetByIndexLoading extends TasbehState {}

final class TasbehGetByIndexSuccess extends TasbehState {
  final TasbehModel tasbeh;
  TasbehGetByIndexSuccess({required this.tasbeh});
}

final class TasbehGetByIndexFailure extends TasbehState {
  final String message;
  TasbehGetByIndexFailure({required this.message});
}

final class TasbehResetLoading extends TasbehState {}

final class TasbehResetSuccess extends TasbehState {}

final class TasbehResetFailure extends TasbehState {
  final String message;
  TasbehResetFailure({required this.message});
}

final class TasbehDeleteLoading extends TasbehState {}

final class TasbehDeleteSuccess extends TasbehState {}

final class TasbehDeleteFailure extends TasbehState {
  final String message;
  TasbehDeleteFailure({required this.message});
}

final class TasbehChangeEditState extends TasbehState {}
