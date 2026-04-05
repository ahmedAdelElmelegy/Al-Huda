import 'package:al_huda/feature/pharmacy/data/model/mood_prescription.dart';
import 'package:equatable/equatable.dart';

abstract class PharmacyState extends Equatable {
  const PharmacyState();

  @override
  List<Object?> get props => [];
}

class PharmacyInitial extends PharmacyState {}

class PharmacyLoaded extends PharmacyState {
  final List<MoodPrescription> prescriptions;

  const PharmacyLoaded(this.prescriptions);

  @override
  List<Object?> get props => [prescriptions];
}
