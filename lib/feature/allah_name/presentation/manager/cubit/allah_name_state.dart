part of 'allah_name_cubit.dart';

@immutable
sealed class AllahNameState {}

final class AllahNameInitial extends AllahNameState {}

final class AllahNameLoading extends AllahNameState {}

final class AllahNameSuccess extends AllahNameState {
  final List<AllahName> allahNames;
  AllahNameSuccess({required this.allahNames});
}

final class AllahNameError extends AllahNameState {
  final String message;
  AllahNameError({required this.message});
}
