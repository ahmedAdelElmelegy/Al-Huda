import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/radio/data/model/radio_data.dart';
import 'package:al_huda/feature/radio/presentation/widgets/radio_reader_audio.dart';
import 'package:al_huda/feature/radio/presentation/widgets/radio_reader_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioDetailScreen extends StatefulWidget {
  final RadioData radioData;

  final List<RadioData> radioList;
  const RadioDetailScreen({
    super.key,
    required this.radioData,
    required this.radioList,
  });

  @override
  State<RadioDetailScreen> createState() => _RadioDetailScreenState();
}

class _RadioDetailScreenState extends State<RadioDetailScreen> {
  late RadioData selectedRadio; // الراديو الحالي اللي فوق
  late List<RadioData> otherRadios; // باقي الراديوهات

  @override
  void initState() {
    super.initState();
    selectedRadio =
        widget.radioData; // البداية بالراديو اللي جاي من الشاشة السابقة
    otherRadios = List.from(widget.radioList)
      ..removeWhere((element) => element.id == widget.radioData.id);
  }

  void changeRadio(RadioData newRadio) {
    setState(() {
      otherRadios.add(selectedRadio);
      // نشيل الجديد من الـ list
      otherRadios.removeWhere((element) => element.id == newRadio.id);
      // نخلي الجديد هو المختار
      selectedRadio = newRadio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(120),
            ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Image.network(selectedRadio.img!, height: 200),
            ),
            verticalSpace(24),
            Text(
              selectedRadio.name!,
              style: TextSTyle.f18CairoSemiBoldPrimary.copyWith(
                color: ColorManager.primaryText2,
              ),
            ),
            verticalSpace(30),
            RadioReaderAudio(
              radioData: selectedRadio,
              radioList: widget.radioList,
              onRadioChangeRight: changeRadio,
              onRadioChangeLeft: changeRadio,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: otherRadios.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => changeRadio(otherRadios[index]),
                    child: RadioReaderItem(
                      radioData: otherRadios[index],
                      radioList: otherRadios,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
