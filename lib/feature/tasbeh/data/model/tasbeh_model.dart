import 'package:hive_ce/hive.dart';
part 'tasbeh_model.g.dart';

@HiveType(typeId: 0)
class TasbehModel extends HiveObject {
  @HiveField(0)
  int count;
  @HiveField(1)
  String name;
  @HiveField(2)
  bool lock;

  TasbehModel({this.count = 0, required this.name, this.lock = false});
}
