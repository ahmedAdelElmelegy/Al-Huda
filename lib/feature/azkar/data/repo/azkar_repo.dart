import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:al_huda/feature/azkar/data/model/azkar_category.dart';

class AzkarRepo {
  Future<List<AzkarCategory>> loadAzkar() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/azkar.json');
      final jsonList = json.decode(jsonString);
      List<AzkarCategory> catgories = [];
      for (var item in jsonList) {
        catgories.add(AzkarCategory.fromJson(item));
      }
      return catgories;
    } catch (e) {
      rethrow;
    }
  }
}
