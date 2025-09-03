import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:flutter/material.dart';

class QranChangFontSizeSetting extends StatefulWidget {
  const QranChangFontSizeSetting({super.key});

  @override
  State<QranChangFontSizeSetting> createState() =>
      _QranChangFontSizeSettingState();
}

class _QranChangFontSizeSettingState extends State<QranChangFontSizeSetting> {
  double _fontSize = 16;

  final List<double> sizes = [16, 18, 20, 22, 24];
  @override
  void initState() {
    super.initState();
    _getCurrentFontSize();
  }

  Future<void> _getCurrentFontSize() async {
    double fontSize =
        await SharedPrefServices.getDoubleValue(Constants.qranFontSize) ?? 16;
    setState(() {
      _fontSize = fontSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.format_size, color: ColorManager.gray),
            horizontalSpace(4),
            Text(
              "حجم الخط",
              style: TextSTyle.f12CairoRegGrey.copyWith(
                color: ColorManager.black,
                fontFamily: TextSTyle.sSTArabicLight,
              ),
            ),
          ],
        ),
        verticalSpace(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: sizes.map((size) {
            return Text(
              size.toString(),
              style: TextStyle(
                color: _fontSize == size ? Colors.blue : Colors.grey,
                fontWeight: _fontSize == size
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
        verticalSpace(8),
        Slider(
          padding: EdgeInsets.zero,
          activeColor: ColorManager.primary,
          inactiveColor: ColorManager.gray,
          value: _fontSize,
          min: sizes.first,
          max: sizes.last,
          divisions: sizes.length - 1,
          label: _fontSize.toStringAsFixed(0),
          onChanged: (value) {
            setState(() {
              _fontSize = value;
              SharedPrefServices.setDoubleValue(value, Constants.qranFontSize);
            });
          },
        ),
      ],
    );
  }
}
