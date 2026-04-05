import 'package:hive_ce/hive.dart';

part 'family_member.g.dart';

@HiveType(typeId: 11) // Ensure this ID is unique in the project
class FamilyMember extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String role; // e.g., "Father", "Son", "Daughter"
  @HiveField(3)
  int prayersCount;
  @HiveField(4)
  int quranPagesCount;
  @HiveField(5)
  int azkarCount;

  FamilyMember({
    required this.id,
    required this.name,
    required this.role,
    this.prayersCount = 0,
    this.quranPagesCount = 0,
    this.azkarCount = 0,
  });
}
