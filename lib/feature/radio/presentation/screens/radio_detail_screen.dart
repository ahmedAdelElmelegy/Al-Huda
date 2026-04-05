import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/radio/data/model/radio_data.dart';
import 'package:al_huda/feature/radio/presentation/widgets/radio_reader_audio.dart';
import 'package:al_huda/feature/radio/presentation/widgets/radio_reader_item.dart';
import 'package:easy_localization/easy_localization.dart';
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
  late RadioData selectedRadio;
  late List<RadioData> otherRadios;

  @override
  void initState() {
    super.initState();
    selectedRadio = widget.radioData;
    otherRadios = List.from(widget.radioList)
      ..removeWhere((element) => element.id == widget.radioData.id);
  }

  void changeRadio(RadioData newRadio) {
    setState(() {
      otherRadios.add(selectedRadio);

      otherRadios.removeWhere((element) => element.id == newRadio.id);

      selectedRadio = newRadio;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? ColorManager.backgroundDark
          : ColorManager.background,
      appBar: AppBar(
        title: Text(
          selectedRadio.name!,
          style: TextStyle(
            fontFamily: 'SSTArabicMedium',
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.primary,
        elevation: 4,
        shadowColor: ColorManager.primary.withValues(alpha: 0.2),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(40),
            // Luxury Station Card
            Container(
              width: 200.w,
              height: 200.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.primary.withValues(alpha: 0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
                border: Border.all(
                  color: ColorManager.primary.withValues(alpha: 0.2),
                  width: 3,
                ),
                image: DecorationImage(
                  image: NetworkImage(selectedRadio.img!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            verticalSpace(32),
            Text(
              selectedRadio.name!,
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 22.sp,
                color: isDark ? Colors.white : ColorManager.textHigh,
                letterSpacing: -0.5,
              ),
            ),
            verticalSpace(40),
            // Premium Player Controls
            RadioReaderAudio(
              radioData: selectedRadio,
              radioList: widget.radioList,
              onRadioChangeRight: changeRadio,
              onRadioChangeLeft: changeRadio,
            ),
            verticalSpace(24),
            // List Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Container(
                    width: 3.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  horizontalSpace(10),
                  Text(
                    'radio'.tr(), // Or 'Other Stations'
                    style: TextStyle(
                      fontFamily: 'SSTArabicMedium',
                      fontSize: 16.sp,
                      color: isDark ? Colors.white70 : ColorManager.textHigh,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
            verticalSpace(40),
          ],
        ),
      ),
    );
  }
}
