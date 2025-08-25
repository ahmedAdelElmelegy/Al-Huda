// quran_model.dart

import 'package:al_huda/feature/qran/data/model/ayat_model/surah_model_data.dart';

class QuranModel {
  final int code;
  final String status;
  final SurahModelData data;

  QuranModel({required this.code, required this.status, required this.data});

  factory QuranModel.fromJson(Map<String, dynamic> json) {
    return QuranModel(
      code: json['code'],
      status: json['status'],
      data: SurahModelData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'status': status, 'data': data.toJson()};
  }
}
