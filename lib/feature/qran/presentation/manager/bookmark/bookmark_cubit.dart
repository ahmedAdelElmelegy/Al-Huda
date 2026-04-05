import 'package:al_huda/feature/qran/data/model/bookmark_model/bookmark_model.dart';
import 'package:al_huda/feature/qran/presentation/manager/bookmark/bookmark_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final BookmarkService _bookmarkService;

  BookmarkCubit(this._bookmarkService) : super(BookmarkInitial());

  void loadBookmarks() {
    try {
      emit(BookmarkLoading());
      final bookmarks = _bookmarkService.getBookmarks();
      emit(BookmarkLoaded(bookmarks));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  Future<void> addBookmark({
    required int surahNumber,
    required int ayahNumber,
    required String text,
  }) async {
    try {
      final id = '${surahNumber}_$ayahNumber';
      final bookmark = BookmarkModel(
        id: id,
        surahNumber: surahNumber,
        ayahNumber: ayahNumber,
        text: text,
        timestamp: DateTime.now(),
      );

      await _bookmarkService.addBookmark(bookmark);
      loadBookmarks();
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  Future<void> removeBookmark(String id) async {
    try {
      await _bookmarkService.removeBookmark(id);
      loadBookmarks();
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  bool isBookmarked(int surahNumber, int ayahNumber) {
    return _bookmarkService.isBookmarked('${surahNumber}_$ayahNumber');
  }
}
