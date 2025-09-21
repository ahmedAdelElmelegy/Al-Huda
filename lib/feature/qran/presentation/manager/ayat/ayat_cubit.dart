import 'package:al_huda/core/data/response/api_response.dart';
import 'package:al_huda/core/error/failure.dart';
import 'package:al_huda/core/services/qran_services.dart';
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

  Future<ApiResponse> getAyat(int surahNumber, String readerName) async {
    emit(AyatLoading());

    ayatList.clear();
    final surahModelData = await QranServices().getAllAyahFromHive(surahNumber);
    final response = await ayatRepo.getAyat(surahNumber, readerName);

    if (surahModelData == null) {
      if (response.response != null &&
          response.response!.statusCode == 200 &&
          response.response!.data != null) {
        quranModel = QuranModel.fromJson(response.response!.data);

        if (quranModel!.code == 200) {
          await QranServices().addAyahOfSoura(quranModel!.data);

          ayatList.addAll(quranModel!.data.ayahs);
        }
        emit(AyatSuccess(ayatList: ayatList));
      } else {
        emit(AyatError(failure: ServerFailure(response.error)));
      }
    } else {
      ayatList.addAll(surahModelData.ayahs);
      emit(AyatSuccess(ayatList: ayatList));
    }
    return response;
  }

  // au
}
