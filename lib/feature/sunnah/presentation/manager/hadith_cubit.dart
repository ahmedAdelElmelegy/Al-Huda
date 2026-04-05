import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/hadith_model.dart';
import '../../data/repo/hadith_repo.dart';

abstract class HadithState {}
class HadithInitial extends HadithState {}
class HadithLoading extends HadithState {}
class HadithLoaded extends HadithState {
  final List<HadithModel> hadiths;
  final bool hasReachedMax;
  final bool isLoadingMore;

  HadithLoaded(this.hadiths, {this.hasReachedMax = false, this.isLoadingMore = false});
}
class HadithError extends HadithState {
  final String message;
  HadithError(this.message);
}

class HadithCubit extends Cubit<HadithState> {
  final HadithRepo repo;
  HadithCubit(this.repo) : super(HadithInitial());

  List<HadithModel> _allHadiths = [];
  int _currentPage = 1;
  String? _currentBook;

  Future<void> getHadiths(String bookName, {bool reset = false}) async {
    if (reset) {
      _currentPage = 1;
      _allHadiths = [];
      _currentBook = bookName;
      emit(HadithLoading());
    } else {
      if (state is HadithLoaded) {
        final currentState = state as HadithLoaded;
        if (currentState.hasReachedMax || currentState.isLoadingMore) return;
        emit(HadithLoaded(_allHadiths, isLoadingMore: true));
      }
    }

    try {
      final newHadiths = await repo.getHadiths(bookName: _currentBook!, pageNumber: _currentPage);
      if (newHadiths.isEmpty) {
        emit(HadithLoaded(_allHadiths, hasReachedMax: true));
      } else {
        _allHadiths.addAll(newHadiths);
        _currentPage++;
        emit(HadithLoaded(_allHadiths, hasReachedMax: false));
      }
    } catch (e) {
      emit(HadithError(e.toString()));
    }
  }

  void loadMore() {
    if (_currentBook != null) {
      getHadiths(_currentBook!);
    }
  }
}
