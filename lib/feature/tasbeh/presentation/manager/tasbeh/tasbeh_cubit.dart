import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/services/tasbeh_services.dart';
import 'package:al_huda/feature/tasbeh/data/model/tasbeh_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'tasbeh_state.dart';

class TasbehCubit extends Cubit<TasbehState> {
  TasbehCubit(this.tasbehServices) : super(TasbehInitial());

  final TasbehServices tasbehServices;
  List<TasbehModel> tasbehList = [];
  int totalTasbeeh = 0;
  int treesPlanted = 0;

  Future<void> getTasbeh() async {
    emit(TasbehLoading());
    try {
      tasbehList = await tasbehServices.getTasbeh();
      totalTasbeeh = await tasbehServices.getTotalTasbeeh();
      treesPlanted = await tasbehServices.getTreesPlanted();

      emit(TasbehSuccess(tasbehList: tasbehList));
    } catch (e) {
      emit(TasbehFailure(message: e.toString()));
    }
  }

  TextEditingController zekrController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Future<void> addTasbeh(TasbehModel tasbeh) async {
    emit(TasbehAddLoading());
    try {
      await tasbehServices.addTasbeh(tasbeh);
      getTasbeh();
      emit(TasbehAddSuccess());
      zekrController.clear();
      pop();
    } catch (e) {
      emit(TasbehAddFailure(message: e.toString()));
    }
  }

  int currentIndex = 0;

  Future<void> incrementTasbeh() async {
    final box = await tasbehServices.openBox();
    final tasbeh = box.getAt(currentIndex);
    if (tasbeh != null) {
      tasbeh.count++;
      await box.putAt(currentIndex, tasbeh);

      // Jannah Trees Logic
      totalTasbeeh++;
      await tasbehServices.saveTotalTasbeeh(totalTasbeeh);

      if (totalTasbeeh % 100 == 0) {
        treesPlanted++;
        await tasbehServices.saveTreesPlanted(treesPlanted);
        emit(TasbehMilestoneReached(totalTrees: treesPlanted));
      }

      emit(TasbehIncrementSuccess());
      getTasbehByIndex(currentIndex);
    }
  }

  TasbehModel? currentTasbeh;

  Future<void> getTasbehByIndex(int index) async {
    emit(TasbehGetByIndexLoading());
    try {
      final tasbeh = await tasbehServices.getTasbehByIndex(index);
      currentTasbeh = tasbeh;
      currentIndex = index;
      emit(TasbehGetByIndexSuccess(tasbeh: tasbeh!));
    } catch (e) {
      emit(TasbehGetByIndexFailure(message: e.toString()));
    }
  }

  Future<void> resetTasbeh() async {
    emit(TasbehResetLoading());
    try {
      await tasbehServices.resetTasbeh(currentIndex);
      getTasbehByIndex(currentIndex); // Refresh current tasbeh
      emit(TasbehResetSuccess());
    } catch (e) {
      emit(TasbehResetFailure(message: e.toString()));
    }
  }

  Future<void> deleteTasbeh(int index) async {
    emit(TasbehDeleteLoading());
    try {
      await tasbehServices.deleteTasbeh(index);
      emit(TasbehDeleteSuccess());
      getTasbeh();
      pop();
    } catch (e) {
      emit(TasbehDeleteFailure(message: e.toString()));
    }
  }

  bool isEdit = true;
  void changeEditState() {
    isEdit = !isEdit;
    emit(TasbehChangeEditState());
  }
}
