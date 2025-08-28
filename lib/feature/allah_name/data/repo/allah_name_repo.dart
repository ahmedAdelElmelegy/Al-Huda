import 'dart:convert';

import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:flutter/services.dart';
import 'package:al_huda/feature/allah_name/data/model/allah_name_model.dart';

class AllahNameRepo {
  Future<List<AllahName>> loadAllahNames() async {
    try {
      String jsonString = await rootBundle.loadString(AppURL.allahNames);
      final jsonList = json.decode(jsonString);
      List<AllahName> allahNames = [];
      for (var item in jsonList) {
        allahNames.add(AllahName.fromJson(item));
      }
      return allahNames;
    } catch (e) {
      rethrow;
    }
  }
}
