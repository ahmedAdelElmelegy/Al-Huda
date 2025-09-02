import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:flutter/material.dart';

class AyatAppBar extends StatelessWidget {
  final SurahData surahData;
  const AyatAppBar({super.key, required this.surahData});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(surahData.name!, style: TextSTyle.f12AmiriRegPrimary),
    );
  }
}
