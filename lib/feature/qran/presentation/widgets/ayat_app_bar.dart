import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AyatAppBar extends StatelessWidget {
  final SurahData surahData;
  const AyatAppBar({super.key, required this.surahData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${tr('part')} 1 ,', style: TextSTyle.f12CairoSemiBoldPrimary),
        horizontalSpace(8),
        Text('${tr('chapter')} 1', style: TextSTyle.f12CairoSemiBoldPrimary),
        Spacer(),
        Text(surahData.name!, style: TextSTyle.f12AmiriRegPrimary),
      ],
    );
  }
}
