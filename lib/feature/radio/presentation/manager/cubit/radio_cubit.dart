import 'package:al_huda/core/data/response/api_response.dart';
import 'package:al_huda/core/error/failure.dart';
import 'package:al_huda/feature/radio/data/model/radio_data.dart';
import 'package:al_huda/feature/radio/data/model/radio_model.dart';
import 'package:al_huda/feature/radio/data/repo/radio_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  RadioCubit(this.radioRepo) : super(RadioInitial());
  RadioRepo radioRepo;
  RadioModel? radioModel;
  ServerFailure? serverFailure;
  List<RadioData> radioList = [];
  Future<ApiResponse> getRadio() async {
    emit(RadioLoading());
    var response = await radioRepo.getRadio();
    if (response.response?.statusCode == 200 &&
        response.response?.data != null &&
        response.response?.data is Map<String, dynamic>) {
      radioModel = RadioModel.fromJson(response.response?.data);
      radioList.addAll(radioModel!.radios ?? []);
      emit(RadioSuccess(data: radioModel!));
    } else {
      emit(
        RadioError(message: ServerFailure(response.error!.message).errMessage),
      );
    }

    return response;
  }
}
