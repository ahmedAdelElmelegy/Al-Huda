import 'package:al_huda/core/services/azkar_services.dart';
import 'package:al_huda/core/services/doaa_services.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:al_huda/feature/doaa/data/model/doaa_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.doaaServices, this.azkarServices)
    : super(FavoriteInitial());

  DoaaServices doaaServices;
  final AzkarServices azkarServices;

  // for azkar

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

  // for doaa
  void addDoaa(DoaaModelData doaa, int index) {
    emit(FavoriteAddDoaaLoading());
    try {
      final doaaModelData = DoaaModelData(
        id: doaa.id,
        text: doaa.text,
        info: doaa.info,
        category: Constants.doaaNameList[index],
      );
      if (doaaModelData.category != null) {
        doaaServices.addDoaa(doaaModelData);
        getDoaaByCategory(Constants.doaaNameList[index]);
        emit(FavoriteAddDoaaSuccess());
        Fluttertoast.showToast(msg: 'تمت الإضافة بنجاح');
      }
    } catch (e) {
      emit(FavoriteAddDoaaError(e.toString()));
      Fluttertoast.showToast(msg: 'حدث خطأ');
    }
  }

  List<DoaaModelData> doaaList = [];
  // get doaa by category
  void getDoaaByCategory(String category) async {
    emit(FavoriteGetDoaaByCategoryLoading());
    try {
      doaaList = await doaaServices.getDoaaByCategory(category);
      emit(FavoriteGetDoaaByCategorySuccess());
    } catch (e) {
      emit(FavoriteGetDoaaByCategoryError(e.toString()));
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  bool isDoaaInFavorite(DoaaModelData doaa) {
    return doaaList.any((element) => element.id == doaa.id);
  }

  // // delete doaa
  void deleteDoaa(int index) {
    emit(FavoriteDeleteDoaaLoading());
    try {
      doaaServices.deleteDoaa(index);
      getDoaaByCategory(doaaList[index].category!);
      emit(FavoriteDeleteDoaaSuccess());
      Fluttertoast.showToast(msg: 'تم حذف الدعاء');
    } catch (e) {
      emit(FavoriteDeleteDoaaError(e.toString()));
      Fluttertoast.showToast(msg: 'حدث خطأ');
    }
  }

  void deleteAzkarById(int id) {
    emit(AzkarDeleteByIdLoading());
    try {
      azkarServices.deleteZikrById(id);
      getAllZikr();
      emit(AzkarDeleteByIdSuccess());
      Fluttertoast.showToast(msg: 'تم حذف الذكر');
    } catch (e) {
      emit(AzkarDeleteByIdError(e.toString()));
      Fluttertoast.showToast(msg: 'حدث خطأ');
    }
  }

  void deleteDoaaById(String id, int index) {
    emit(FavoriteDeleteDoaaByIdLoading());
    try {
      doaaServices.deleteDoaaById(id);
      getDoaaByCategory(Constants.doaaNameList[index]);
      emit(FavoriteDeleteDoaaByIdSuccess());
      Fluttertoast.showToast(msg: 'تم حذف الدعاء');
    } catch (e) {
      emit(FavoriteDeleteDoaaByIdError(e.toString()));
      Fluttertoast.showToast(msg: 'حدث خطأ');
    }
  }
}
