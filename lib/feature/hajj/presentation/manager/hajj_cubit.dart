import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/hajj_repo.dart';
import 'hajj_state.dart';

class HajjCubit extends Cubit<HajjState> {
  final HajjRepo _hajjRepo;

  HajjCubit(this._hajjRepo) : super(HajjInitial());

  Future<void> loadHajjUmrahData() async {
    emit(HajjLoading());
    try {
      final data = await _hajjRepo.getHajjUmrahData();
      emit(HajjLoaded(data));
    } catch (e) {
      emit(HajjError(e.toString()));
    }
  }
}
