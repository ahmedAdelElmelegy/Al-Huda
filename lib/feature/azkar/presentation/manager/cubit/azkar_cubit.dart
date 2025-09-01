import 'package:al_huda/core/services/azkar_services.dart';
import 'package:al_huda/feature/azkar/data/model/azkar_category.dart';
import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:al_huda/feature/azkar/data/repo/azkar_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  Future<void> addAzkar(Zikr zikr) async {
    emit(AzkarAddLoading());
    try {
      await getAllZikr();
      if (zikrList.contains(zikr)) {
        emit(AzkarAddError());
        Fluttertoast.showToast(msg: 'تم إضافة الذكر');
        return;
      }
      await azkarServices.addZikr(zikr);
      emit(AzkarAddSuccess());
      Fluttertoast.showToast(msg: 'تم إضافة الذكر');
    } catch (e) {
      emit(AzkarAddError());
      Fluttertoast.showToast(msg: 'حدث خطأ');
    }
  }

  bool isFav(Zikr zikr) {
    getAllZikr();
    return zikrList.contains(zikr);
  }

  // get all zikr
  List<Zikr> zikrList = [];
  Future<void> getAllZikr() async {
    emit(AzkarGetAllLoading());
    try {
      zikrList = await azkarServices.getAllZikr();
      emit(AzkarGetAllSuccess());
    } catch (e) {
      emit(AzkarGetAllError());
      Fluttertoast.showToast(msg: 'حدث خطأ');
    }
  }

  Future<void> updateAzkar(int index, Zikr zikr) async {
    emit(AzkarUpdateLoading());
    try {
      await azkarServices.updateZikr(index, zikr);
      emit(AzkarUpdateSuccess());
      Fluttertoast.showToast(msg: 'تم تحديث الذكر');
    } catch (e) {
      emit(AzkarUpdateError());
      Fluttertoast.showToast(msg: 'حدث خطأ');
    }
  }

  Future<void> deleteAzkar(int index) async {
    emit(AzkarDeleteLoading());
    try {
      await azkarServices.deleteZikr(index);
      emit(AzkarDeleteSuccess());
      getAllZikr();
      Fluttertoast.showToast(msg: 'تم حذف الذكر');
    } catch (e) {
      emit(AzkarDeleteError());
      Fluttertoast.showToast(msg: 'حدث خطأ');
    }
  }
}
