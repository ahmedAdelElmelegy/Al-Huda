import 'package:al_huda/feature/family/data/model/family_member.dart';
import 'package:al_huda/feature/family/data/repo/family_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'family_state.dart';

class FamilyCubit extends Cubit<FamilyState> {
  final FamilyRepo _familyRepo;

  FamilyCubit(this._familyRepo) : super(FamilyInitial());

  Future<void> getMembers() async {
    emit(FamilyLoading());
    try {
      final members = await _familyRepo.getMembers();
      emit(FamilySuccess(members: members));
    } catch (e) {
      emit(FamilyFailure(message: e.toString()));
    }
  }

  Future<void> addMember(FamilyMember member) async {
    try {
      await _familyRepo.addMember(member);
      getMembers();
    } catch (e) {
      emit(FamilyFailure(message: e.toString()));
    }
  }

  Future<void> deleteMember(int index) async {
    try {
      await _familyRepo.deleteMember(index);
      getMembers();
    } catch (e) {
      emit(FamilyFailure(message: e.toString()));
    }
  }
}
