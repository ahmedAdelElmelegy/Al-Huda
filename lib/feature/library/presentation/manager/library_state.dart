import '../../data/model/library_models.dart';

abstract class LibraryState {}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class LibraryCategoriesLoaded extends LibraryState {
  final List<CategoryModel> categories;
  LibraryCategoriesLoaded(this.categories);
}

class LibraryArticlesLoaded extends LibraryState {
  final List<ArticleModel> articles;
  final String title;
  LibraryArticlesLoaded(this.articles, this.title);
}

class LibraryError extends LibraryState {
  final String message;
  LibraryError(this.message);
}
