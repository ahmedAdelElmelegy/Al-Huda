import 'dart:convert';
import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:al_huda/feature/doaa/data/model/doaa_model.dart';
import 'package:flutter/services.dart';

class DoaaRepo {
  Future<List<DoaaModelData>> laadAllDoaa(String doaaName) async {
    try {
      String jsonString = await rootBundle.loadString(AppURL.doaa + doaaName);
      final jsonList = json.decode(jsonString);
      List<DoaaModelData> doaaList = [];
      for (var item in jsonList) {
        doaaList.add(DoaaModelData.fromJson(item));
      }
      return doaaList;
    } catch (e) {
      rethrow;
    }
  }
}
