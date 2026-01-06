import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPickerTable extends StatefulWidget {
  final void Function(DateTime selectedDay, DateTime focusedDay)? onDaySelected;
  const CalenderPickerTable({super.key, this.onDaySelected});

  @override
  State<CalenderPickerTable> createState() => _CalenderPickerTableState();
}

class _CalenderPickerTableState extends State<CalenderPickerTable> {
  DateTime? daySelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.primary, width: .5.w),
        color: ColorManager.primary.withValues(alpha: .1),
      ),
      child: TableCalendar(
        headerStyle: HeaderStyle(formatButtonVisible: false),
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: ColorManager.primary,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayDecoration: BoxDecoration(
            color: ColorManager.primary.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),

          todayTextStyle: TextStyle(color: Colors.white),
        ),
        focusedDay: daySelected ?? DateTime.now(),
        firstDay: DateTime(2020),
        lastDay: DateTime(2030),
        locale: 'ar',

        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.saturday,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            daySelected = selectedDay;
          });
          widget.onDaySelected?.call(selectedDay, focusedDay);
        },
        selectedDayPredicate: (day) {
          return isSameDay(daySelected, day);
        },
      ),
    );
  }
}
