import 'package:al_huda/feature/family/data/model/family_member.dart';
import 'package:hive_ce/hive.dart';

class FamilyRepo {
  static const String boxName = "familyBox";

  Future<Box<FamilyMember>> openBox() async {
    return await Hive.openBox<FamilyMember>(boxName);
  }

  Future<List<FamilyMember>> getMembers() async {
    final box = await openBox();
    return box.values.toList();
  }

  Future<void> addMember(FamilyMember member) async {
    final box = await openBox();
    await box.add(member);
  }

  Future<void> deleteMember(int index) async {
    final box = await openBox();
    await box.deleteAt(index);
  }

  Future<void> updateMember(int index, FamilyMember member) async {
    final box = await openBox();
    await box.putAt(index, member);
  }
}
