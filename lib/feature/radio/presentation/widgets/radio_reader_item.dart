import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/radio/data/model/radio_data.dart';
import 'package:flutter/material.dart';

class RadioReaderItem extends StatelessWidget {
  final RadioData radioData;
  final List<RadioData> radioList;
  const RadioReaderItem({
    super.key,
    required this.radioData,
    required this.radioList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorManager.gray.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(2, 2),
          ),
        ],
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              image: DecorationImage(
                image: NetworkImage(radioData.img!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          horizontalSpace(16),
          Text(
            radioData.name!,
            style: TextSTyle.f16AmiriBoldPrimary.copyWith(
              color: ColorManager.primaryText2,
            ),
          ),
        ],
      ),
    );
  }
}
