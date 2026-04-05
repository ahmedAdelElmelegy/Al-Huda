import 'package:al_huda/feature/pharmacy/data/repo/pharmacy_repo.dart';
import 'package:al_huda/feature/pharmacy/presentation/manager/pharmacy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  final PharmacyRepo _pharmacyRepo;

  PharmacyCubit(this._pharmacyRepo) : super(PharmacyInitial());

  void loadPharmacy() {
    final presets = _pharmacyRepo.getPresets();
    emit(PharmacyLoaded(presets));
  }
}
