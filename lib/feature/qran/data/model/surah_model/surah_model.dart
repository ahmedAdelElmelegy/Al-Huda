import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';

class SurahModel {
  final int? code;
  final String? status;
  final List<SurahData>? data;

  SurahModel({this.code, this.status, this.data});

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      code: json['code'],
      status: json['status'],
      data: json['data'] != null
          ? List<SurahData>.from(json['data'].map((x) => SurahData.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}
