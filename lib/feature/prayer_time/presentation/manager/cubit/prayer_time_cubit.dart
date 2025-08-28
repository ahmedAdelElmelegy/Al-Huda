import 'package:al_huda/feature/prayer_time/data/model/prayer_time_model.dart';
import 'package:al_huda/feature/prayer_time/data/repo/prayer_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'prayer_time_state.dart';

class PrayerTimeCubit extends Cubit<PrayerTimeState> {
  PrayerTimeCubit(this.prayerRepo) : super(PrayerTimeInitial());
  PrayerRepo prayerRepo;
  Timings? timings;
  PrayerTimeModel? prayerTimeModel;

  Future<void> getPrayerTime(String latitude, String longitude) async {
    emit(PrayerTimeLoading());
    final apiResponse = await prayerRepo.getPrayerTime(latitude, longitude);
    if (apiResponse.response!.statusCode == 200 &&
        apiResponse.response != null &&
        apiResponse.response!.data != null) {
      prayerTimeModel = PrayerTimeModel.fromJson(apiResponse.response!.data);
      timings = prayerTimeModel?.data?.timings;
      emit(PrayerTimeSuccess());
    } else {
      emit(PrayerTimeError(message: apiResponse.response!.data.toString()));
    }
  }
}
