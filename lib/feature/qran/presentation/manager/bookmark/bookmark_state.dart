part of 'bookmark_cubit.dart';

@immutable
abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<BookmarkModel> bookmarks;
  BookmarkLoaded(this.bookmarks);
}

class BookmarkError extends BookmarkState {
  final String message;
  BookmarkError(this.message);
}
