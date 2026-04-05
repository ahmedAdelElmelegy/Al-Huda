import 'package:al_huda/feature/qran/data/model/bookmark_model/bookmark_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class BookmarkService {
  static const String boxName = 'bookmarksBox';

  static Future<void> init() async {
    await Hive.openBox<BookmarkModel>(boxName);
  }

  Box<BookmarkModel> get _box => Hive.box<BookmarkModel>(boxName);

  List<BookmarkModel> getBookmarks() {
    return _box.values.toList()..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<void> addBookmark(BookmarkModel bookmark) async {
    await _box.put(bookmark.id, bookmark);
  }

  Future<void> removeBookmark(String id) async {
    await _box.delete(id);
  }

  bool isBookmarked(String id) {
    return _box.containsKey(id);
  }

  Future<void> clearBookmarks() async {
    await _box.clear();
  }
}
