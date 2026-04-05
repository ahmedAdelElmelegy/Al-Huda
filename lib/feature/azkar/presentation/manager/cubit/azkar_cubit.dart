import 'package:al_huda/core/error/result.dart';
import 'package:al_huda/core/services/azkar_services.dart';
import 'package:al_huda/feature/azkar/domain/entities/azkar_category_entity.dart';
import 'package:al_huda/feature/azkar/domain/repositories/azkar_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit(this.azkarRepository, this.azkarServices) : super(AzkarInitial());
  final AzkarRepository azkarRepository;
  final AzkarServices azkarServices;
  List<AzkarCategoryEntity> azkarCategories = [];

  void loadAzkar() async {
    emit(AzkarLoading());
    final result = await azkarRepository.getAzkarCategories();
    if (result is Success<List<AzkarCategoryEntity>>) {
      azkarCategories = result.data;
      emit(AzkarLoaded());
    } else if (result is Error<List<AzkarCategoryEntity>>) {
      emit(AzkarError(result.failure.errMessage));
    }
  }
}
