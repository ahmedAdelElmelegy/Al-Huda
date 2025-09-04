import 'package:al_huda/core/data/response/api_response.dart';
import 'package:al_huda/core/error/failure.dart';
import 'package:al_huda/core/services/qran_services.dart';
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
    List<SurahData> surahListFromHive = await QranServices()
        .getAllSouraFromHive();

    surahList.clear();

    if (surahListFromHive.isEmpty) {
      if (response.response != null &&
          response.response!.statusCode == 200 &&
          response.response!.data != null) {
        surahModel = SurahModel.fromJson(response.response!.data);

        if (surahModel != null && surahModel!.code == 200) {
          surahList.addAll(surahModel!.data ?? []);
          await QranServices().addSouraToHive(surahList);
          emit(QranSuccess(data: surahList));
        } else {
          emit(QranError(failure: ServerFailure(response.error)));
        }
      } else {
        emit(QranError(failure: ServerFailure(response.error)));
      }
    } else {
      surahList.addAll(surahListFromHive);
      emit(QranSuccess(data: surahList));
    }

    return response;
  }

  List<SurahData> searchList = [];
  // search for soura
  String removeDiacritics(String text) {
    final arabicDiacritics = RegExp(r'[\u064B-\u0652]');
    return text.replaceAll(arabicDiacritics, '');
  }

  void searchSurah(String query) {
    emit(QranLoading());

    final cleanQuery = removeDiacritics(query);

    final filteredSurahList = surahList.where((surah) {
      final cleanName = removeDiacritics(
        surah.name!.replaceFirst('سورة', '').trim(),
      );

      return cleanName.contains(cleanQuery);
    }).toList();

    searchList
      ..clear()
      ..addAll(filteredSurahList);

    emit(QranSearch());
  }
}
