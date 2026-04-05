import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/library_repo.dart';
import 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final LibraryRepo libraryRepo;

  LibraryCubit(this.libraryRepo) : super(LibraryInitial());

  Future<void> loadCategories() async {
    emit(LibraryLoading());
    try {
      final categories = await libraryRepo.getCategories();
      emit(LibraryCategoriesLoaded(categories));
    } catch (e) {
      emit(LibraryError('Failed to load categories: ${e.toString()}'));
    }
  }

  Future<void> loadProphetArticles() async {
    emit(LibraryLoading());
    try {
      final articles = await libraryRepo.getProphetArticles();
      emit(LibraryArticlesLoaded(articles, 'قصص الأنبياء'));
    } catch (e) {
      emit(LibraryError('Failed to load prophet articles: ${e.toString()}'));
    }
  }

  Future<void> loadSieraArticles() async {
    emit(LibraryLoading());
    try {
      final articles = await libraryRepo.getSieraArticles();
      emit(LibraryArticlesLoaded(articles, 'السيرة النبوية'));
    } catch (e) {
      emit(LibraryError('Failed to load sira articles: ${e.toString()}'));
    }
  }
}
