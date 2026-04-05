import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/hajj_model.dart';

abstract class HajjRepo {
  Future<HajjUmrahData> getHajjUmrahData();
}

class HajjRepoImpl implements HajjRepo {
  @override
  Future<HajjUmrahData> getHajjUmrahData() async {
    final String response = await rootBundle.loadString('assets/data/hajj_umrah.json');
    final data = await json.decode(response);
    return HajjUmrahData.fromJson(data);
  }
}
