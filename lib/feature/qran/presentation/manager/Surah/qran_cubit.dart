import 'package:al_huda/core/data/response/api_response.dart';
import 'package:al_huda/core/error/failure.dart';
import 'package:al_huda/feature/qran/data/Repo/qran_repo.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'qran_state.dart';

class QranCubit extends Cubit<QranState> {
  QranCubit(this.qranRepo) : super(QranInitial());
  QranRepo qranRepo;
  SurahModel? surahModel;
  ServerFailure? serverFailure;
  List<SurahData> surahList = [];
  Future<ApiResponse> fetchSurah() async {
    emit(QranLoading());

    final response = await qranRepo.getQuran();
    if (response.response!.statusCode == 200 &&
        response.response != null &&
        response.response!.data != null) {
      surahModel = SurahModel.fromJson(response.response!.data);
      if (surahModel!.code == 200) {
        surahList.addAll(surahModel!.data!);
      }
      emit(QranSuccess(data: surahList));
    } else {
      emit(
        QranError(message: ServerFailure(response.error!.message).errMessage),
      );
    }

    return response;
  }
}
