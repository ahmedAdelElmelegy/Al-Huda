import 'package:al_huda/feature/allah_name/data/model/allah_name_model.dart';
import 'package:al_huda/feature/allah_name/data/repo/allah_name_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'allah_name_state.dart';

class AllahNameCubit extends Cubit<AllahNameState> {
  AllahNameCubit(this.allahNameRepo) : super(AllahNameInitial());
  AllahNameRepo allahNameRepo;
  List<AllahName> allahNames = [];
  void getAllahNames() async {
    emit(AllahNameLoading());
    try {
      final allahNames = await allahNameRepo.loadAllahNames();
      this.allahNames = allahNames;
      emit(AllahNameSuccess(allahNames: allahNames));
    } catch (e) {
      emit(AllahNameError(message: e.toString()));
    }
  }
}
