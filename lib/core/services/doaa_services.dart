import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/doaa/data/model/doaa_model.dart';
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
    await box.add(doaa);
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
}
