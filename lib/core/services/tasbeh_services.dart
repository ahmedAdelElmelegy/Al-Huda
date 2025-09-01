import 'package:al_huda/feature/tasbeh/data/model/tasbeh_model.dart';
import 'package:flutter/services.dart';
import 'package:hive_ce/hive.dart';

class TasbehServices {
  static const String boxName = "tasbehBox";

  // create box
  Future<Box<TasbehModel>> openBox() async {
    return await Hive.openBox<TasbehModel>(boxName);
  }

  // add tasbeh
  Future<void> addTasbeh(TasbehModel tasbeh) async {
    final box = await openBox();
    await box.add(tasbeh);
  }

  // get tasbeh
  Future<List<TasbehModel>> getTasbeh() async {
    final box = await openBox();
    return box.values.toList();
  }

  Future<void> updateTasbeh(int index, TasbehModel tasbeh) async {
    final box = await openBox();
    await box.putAt(index, tasbeh);
  }

  // delete
  Future<void> deleteTasbeh(int index) async {
    final box = await openBox();
    await box.deleteAt(index);
  }

  Future<void> clearAll() async {
    final box = await openBox();
    await box.clear();
  }

  // get tasbeh by index
  Future<TasbehModel?> getTasbehByIndex(int index) async {
    final box = await openBox();
    return box.get(index);
  }

  // i need to reset a counter of tasbeh
  Future<void> resetTasbeh(int index) async {
    final box = await openBox();
    final tasbeh = box.get(index);
    tasbeh!.count = 0;
    await box.putAt(index, tasbeh);
  }

  // init tasbeh
  Future<void> initTasbeh() async {
    final box = await openBox();

    if (box.values.isEmpty) {
      final defaultTasbeh = [
        TasbehModel(name: "سبحان الله", count: 0, lock: true),
        TasbehModel(name: "الحمد لله", count: 0, lock: true),
        TasbehModel(name: "لا إله إلا الله", count: 0, lock: true),
        TasbehModel(name: "الله أكبر", count: 0, lock: true),
        TasbehModel(
          name: "لا حول ولا قوة إلا بالله العلي العظيم",
          count: 0,
          lock: true,
        ),
        TasbehModel(name: "سبحان الله العظيم وبحمده", count: 0, lock: true),
        TasbehModel(
          name:
              "لا إله إلا الله وحده لا شريك له، له الملك وله الحمد، وهو على كل شيء قدير",
          count: 0,
          lock: true,
        ),
      ];

      await box.addAll(defaultTasbeh);
    }
  }
}
