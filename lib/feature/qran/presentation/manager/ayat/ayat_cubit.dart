import 'package:al_huda/core/data/response/api_response.dart';
import 'package:al_huda/core/error/failure.dart';
import 'package:al_huda/feature/qran/data/Repo/ayat_repo.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/ayat.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/qran_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'ayat_state.dart';

class AyatCubit extends Cubit<AyatState> {
  AyatCubit(this.ayatRepo) : super(AyatInitial());
  AyatRepo ayatRepo;
  QuranModel? quranModel;
  List<Ayah> ayatList = [];
  ServerFailure? serverFailure;

  Future<ApiResponse> getAyat(int surahNumber) async {
    emit(AyatLoading());
    final response = await ayatRepo.getAyat(surahNumber);
    if (response.response!.statusCode == 200 &&
        response.response != null &&
        response.response!.data != null) {
      quranModel = QuranModel.fromJson(response.response!.data);
      if (quranModel!.code == 200) {
        ayatList.clear();
        ayatList.addAll(quranModel!.data.ayahs);
      }
      emit(AyatSuccess(ayatList: ayatList));
    } else {
      emit(
        AyatError(message: ServerFailure(response.error!.message).errMessage),
      );
    }
    return response;
  }
}
