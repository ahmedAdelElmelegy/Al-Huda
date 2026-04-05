import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/azkar_category.dart';

abstract class AzkarLocalDataSource {
  Future<List<AzkarCategory>> loadAzkar();
}

class AzkarLocalDataSourceImpl implements AzkarLocalDataSource {
  @override
  Future<List<AzkarCategory>> loadAzkar() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/azkar.json');
      final jsonList = json.decode(jsonString) as List;
      List<AzkarCategory> categories = [];
      for (var item in jsonList) {
        categories.add(AzkarCategory.fromJson(item));
      }
      return categories;
    } catch (e) {
      throw Exception('Failed to load azkar from cache');
    }
  }
}
