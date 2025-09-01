import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/calender_services.dart';

import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';
import 'package:al_huda/feature/calender/presentation/widgets/calender_chose_date_type_btn.dart';
import 'package:al_huda/feature/calender/presentation/widgets/calender_list_view.dart';
import 'package:al_huda/feature/calender/presentation/widgets/calender_picker_table.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  int selectedDateType = 0;
  DateTime? daySelected;
  List<String> dateType = ['hijri', 'miladi'];
  @override
  Widget build(BuildContext context) {
    final events = selectedDateType == 0
        ? CalenderServices.getEventsWithGregorian(
            fromDate: daySelected ?? DateTime.now(),
          )
        : CalenderServices.getGregorianEvents(
            fromDate: daySelected ?? DateTime.now(),
          );
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: 'follow_prayer'.tr()),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              verticalSpace(16),
              Row(
                children: List.generate(
                  dateType.length,
                  (index) => Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedDateType = index;
                        });
                      },
                      child: CalenderChoseDateTypeBtn(
                        title: dateType[index],
                        isSelected: index == selectedDateType,
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpace(16),
              CalenderPickerTable(
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    daySelected = selectedDay;
                  });
                },
              ),
              verticalSpace(24),
              EventListView(events: events),
            ],
          ),
        ),
      ),
    );
  }
}
