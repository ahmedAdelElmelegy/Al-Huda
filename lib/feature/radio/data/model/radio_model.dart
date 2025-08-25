import 'package:al_huda/feature/radio/data/model/radio_data.dart';

class RadioModel {
  final List<RadioData>? radios;

  RadioModel({this.radios});

  factory RadioModel.fromJson(Map<String, dynamic> json) {
    return RadioModel(
      radios: json['radios']
          ?.map<RadioData>((e) => RadioData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'radios': radios?.map((e) => e.toJson()).toList()};
  }
}
