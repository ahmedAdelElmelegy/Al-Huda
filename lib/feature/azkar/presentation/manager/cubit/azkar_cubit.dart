import 'package:al_huda/core/services/azkar_services.dart';
import 'package:al_huda/feature/azkar/data/model/azkar_category.dart';
import 'package:al_huda/feature/azkar/data/repo/azkar_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit(this.azkarRepo, this.azkarServices) : super(AzkarInitial());
  final AzkarRepo azkarRepo;
  final AzkarServices azkarServices;
  List<AzkarCategory> azkarCategories = [];
  void loadAzkar() async {
    emit(AzkarLoading());
    try {
      final azkar = await azkarRepo.loadAzkar();
      azkarCategories = azkar;
      emit(AzkarLoaded());
    } catch (e) {
      emit(AzkarError());
    }
  }
}
