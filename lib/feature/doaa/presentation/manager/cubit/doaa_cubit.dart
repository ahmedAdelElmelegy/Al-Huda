import 'package:al_huda/feature/doaa/data/model/doaa_model.dart';
import 'package:al_huda/feature/doaa/data/repo/doaa_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'doaa_state.dart';

class DoaaCubit extends Cubit<DoaaState> {
  DoaaCubit(this.doaaRepo) : super(DoaaInitial());
  DoaaRepo doaaRepo;
  List<DoaaModelData> doaaList = [];

  void getDoaaList(String doaaName) async {
    emit(DoaaLoading());
    try {
      doaaList = await doaaRepo.laadAllDoaa(doaaName);

      emit(DoaaSuccess());
    } catch (e) {
      emit(DoaaError(e.toString()));
    }
  }
}
