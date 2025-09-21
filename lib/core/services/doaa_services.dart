import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/doaa/data/model/doaa_model.dart';
import 'package:al_huda/feature/doaa/presentation/manager/cubit/doaa_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class DoaaServices {
  //  for azkar add to hive
  static const String boxName = Constants.doaaBoxName;

  // create box
  Future<Box<DoaaModelData>> openBox() async {
    return await Hive.openBox<DoaaModelData>(boxName);
  }

  Future<void> addDoaa(DoaaModelData doaa) async {
    final box = await openBox();
    await box.put(doaa.id, doaa);
  }

  // get all zikr
  Future<List<DoaaModelData>> getDoaaByCategory(String category) async {
    final box = await openBox();
    return box.values.where((element) => element.category == category).toList();
  }

  Future<void> deleteDoaa(int index) async {
    final box = await openBox();
    await box.deleteAt(index);
  }

  // delete from doaa screen
  Future<void> deleteDoaaFromScreen(int id) async {
    // delete by id
    final box = await openBox();
    await box.delete(id);
  }

  // doaa delete by id
  Future<void> deleteDoaaById(String id) async {
    final box = await openBox();
    await box.delete(id);
  }

  static const String doaaKey = 'daily_doaa';

  Box get box => Hive.box('doaaDaily');

  String getDailyDoaa(BuildContext context) {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final saved = box.get(doaaKey);
    int index = 0;

    if (saved != null && saved is Map) {
      String lastDate = saved['lastDate'] ?? '';
      int lastIndex = saved['currentIndex'] ?? 0;

      if (lastDate == today) {
        index = lastIndex;
      } else {
        index = (lastIndex + 1) % context.read<DoaaCubit>().doaaList.length;
        _saveDoaa(today, index);
      }
    } else {
      _saveDoaa(today, index);
    }

    return context.read<DoaaCubit>().doaaList[index].text;
  }

  void _saveDoaa(String today, int index) {
    box.put(doaaKey, {"lastDate": today, "currentIndex": index});
  }
}
