import 'dart:math';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/azkar_services.dart';
import 'package:al_huda/core/services/overlay_service.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingAzkarWidget extends StatefulWidget {
  const FloatingAzkarWidget({super.key});

  @override
  State<FloatingAzkarWidget> createState() => _FloatingAzkarWidgetState();
}

class _FloatingAzkarWidgetState extends State<FloatingAzkarWidget> {
  Offset position = const Offset(20, 100);
  String _currentZikr = "سبحان الله وبحمده";
  final Random _random = Random();

  @override
  void initState() {
    _loadRandomZikr();
    super.initState();
  }

  Future<void> _loadRandomZikr() async {
    final azkar = await AzkarServices().getAllZikr();
    if (azkar.isNotEmpty) {
      setState(() {
        _currentZikr = azkar[_random.nextInt(azkar.length)].text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position += details.delta;
          });
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 250.w,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: ColorManager.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: ColorManager.primary,
                      size: 16,
                    ),
                    GestureDetector(
                      onTap: () => OverlayService.hideFloatingAzkar(),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                verticalSpace(8),
                Text(
                  _currentZikr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'CairoMedium',
                    color: Colors.black87,
                  ),
                ),
                verticalSpace(8),
                GestureDetector(
                  onTap: _loadRandomZikr,
                  child: Text(
                    "ذكر آخر",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: ColorManager.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
