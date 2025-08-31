import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/services/time_picker_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/alarm_dialog.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/azkar_detail_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarDetailScreen extends StatefulWidget {
  final List<Zikr> zikr;
  final String zikrName;
  final int index;

  const AzkarDetailScreen({
    super.key,
    required this.zikr,
    required this.zikrName,
    required this.index,
  });

  @override
  State<AzkarDetailScreen> createState() => _AzkarDetailScreenState();
}

class _AzkarDetailScreenState extends State<AzkarDetailScreen> {
  TimeOfDay? _selectedTime;
  late String _formattedTime;
  @override
  void initState() {
    _formattedTime = widget.index == 0 ? '6:00' : '18:00';
    desplayAzkarTime();
    super.initState();
  }

  Future<void> desplayAzkarTime() async {
    _selectedTime = await PrayerServices.convertStringToTimeOfDay(
      'time_${widget.zikrName}',
    );
    if (_selectedTime != null) {
      _formattedTime = TimePickerService.formatTime(_selectedTime!);
      setState(() {});
    }
    debugPrint(_formattedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorManager.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.zikrName,
          style: TextSTyle.f18SSTArabicMediumPrimary.copyWith(
            color: ColorManager.primary,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (widget.index == 0 || widget.index == 1)
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    _formattedTime,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorManager.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                IconButton(
                  icon: Icon(Icons.alarm, color: ColorManager.primary),
                  onPressed: () async {
                    final pickedTime =
                        await TimePickerService.showTimePickerDialog(
                          context,
                          initialTime: _selectedTime,
                        );

                    if (pickedTime != null) {
                      setState(() {
                        _selectedTime = pickedTime;
                        _formattedTime = TimePickerService.formatTime(
                          pickedTime,
                        );
                      });
                      saveAzkarTime(
                        _selectedTime,
                        _formattedTime,
                        widget.index,
                        widget.zikrName,
                      );
                    }
                  },
                ),
              ],
            ),
        ],
      ),
      body: AzkarDetailBody(widget: widget),
    );
  }
}
