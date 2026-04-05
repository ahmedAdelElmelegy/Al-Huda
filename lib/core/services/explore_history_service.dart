import 'package:hive_ce_flutter/hive_flutter.dart';

class ExploreHistoryService {
  static const String boxName = 'explore_history';

  static Future<void> init() async {
    await Hive.openBox(boxName);
  }

  static void recordVisit(String key) {
    final box = Hive.box(boxName);
    // Re-insert to put at the end (most recent)
    if (box.containsKey(key)) {
      box.delete(key);
    }
    box.put(key, DateTime.now().millisecondsSinceEpoch);
    
    // Keep only last 10
    if (box.length > 10) {
      final firstKey = box.keys.first;
      box.delete(firstKey);
    }
  }

  static List<String> getRecent(int count) {
    final box = Hive.box(boxName);
    // Items inserted last are at the end, so reverse to get most recent first
    final keys = box.keys.cast<String>().toList().reversed;
    return keys.take(count).toList();
  }

  static void clear() {
    Hive.box(boxName).clear();
  }
}
