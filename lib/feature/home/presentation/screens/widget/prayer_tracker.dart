import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class PrayerTraker extends StatefulWidget {
  const PrayerTraker({super.key});

  @override
  State<PrayerTraker> createState() => _PrayerTrakerState();
}

class _PrayerTrakerState extends State<PrayerTraker> {
  List<bool> completedPrayers = List.generate(5, (_) => false);
  late Box box;
  static const String prefKey = 'completed_prayers';

  @override
  void initState() {
    super.initState();
    box = Hive.box('completedPrayersBox');
    _loadPrayersFromHive();
  }

  void _loadPrayersFromHive() {
    final saved = box.get(prefKey);
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (saved != null && saved is Map) {
      if ((saved['date'] ?? '') == today) {
        setState(() {
          completedPrayers = List<bool>.from(saved['values'] ?? []);
        });
      } else {
        setState(() => completedPrayers = List.generate(5, (_) => false));
        _savePrayersToHive();
      }
    } else {
      _savePrayersToHive();
    }
  }

  void _savePrayersToHive() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    box.put(prefKey, {'date': today, 'values': completedPrayers});
  }

  void togglePrayer(int index) {
    setState(() => completedPrayers[index] = !completedPrayers[index]);
    _savePrayersToHive();
  }

  int get _completedCount => completedPrayers.where((e) => e).length;
  bool get isAllCompleted => _completedCount == 5;

  String arabicNum(int n) {
    const digits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return n.toString().split('').map((d) => digits[int.parse(d)]).join();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: isDark ? ColorManager.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : ColorManager.primary.withValues(alpha: 0.08),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary.withValues(
                alpha: isDark ? 0.12 : 0.08,
              ),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // ── Interactive Header Hub ────────────────────────────────
            Row(
              children: [
                _ProgressHub(completedCount: _completedCount, isDark: isDark),
                horizontalSpace(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'prayer_tracking'.tr(),
                        style: TextStyle(
                          fontFamily: 'SSTArabicMedium',
                          fontSize: 16.sp,
                          color: isDark ? Colors.white : ColorManager.textHigh,
                        ),
                      ),
                      verticalSpace(2),
                      Text(
                        'keep_up_with_your_daily_salah'.tr(),
                        style: TextStyle(
                          fontFamily: 'SSTArabicRoman',
                          fontSize: 12.sp,
                          color: ColorManager.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            verticalSpace(20),
            Divider(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : ColorManager.primary.withValues(alpha: 0.05),
              height: 1,
            ),
            verticalSpace(12),

            // ── Scenic Prayer Rows ──────────────────────────────────
            ...List.generate(5, (index) {
              final prayer = Constants.prayerWithoutShurooq[index];
              final done = completedPrayers[index];
              return _StaggeredItem(
                index: index,
                child: _PrayerTrackerRow(
                  prayerName: prayer.name,
                  isComplete: done,
                  onToggle: () => togglePrayer(index),
                  isDark: isDark,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ─── Circular Progress Hub (Small) ───────────────────────────────────────────

class _ProgressHub extends StatelessWidget {
  final int completedCount;
  final bool isDark;

  const _ProgressHub({required this.completedCount, required this.isDark});

  @override
  Widget build(BuildContext context) {
    double progress = completedCount / 5;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 50.w,
          height: 50.w,
          child: CircularProgressIndicator(
            value: 1.0,
            strokeWidth: 3.5,
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : ColorManager.primary.withValues(alpha: 0.05),
          ),
        ),
        SizedBox(
          width: 50.w,
          height: 50.w,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 4.5,
            color: ColorManager.primary,
            strokeCap: StrokeCap.round,
          ),
        ),
        Text(
          '$completedCount/٥',
          style: TextStyle(
            fontFamily: 'SSTArabicMedium',
            fontSize: 12.sp,
            color: ColorManager.primary,
          ),
        ),
      ],
    );
  }
}

// ─── Individual Premium Prayer Row ────────────────────────────────────────────

class _PrayerTrackerRow extends StatelessWidget {
  final String prayerName;
  final bool isComplete;
  final VoidCallback onToggle;
  final bool isDark;

  const _PrayerTrackerRow({
    required this.prayerName,
    required this.isComplete,
    required this.onToggle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 11.h),
        child: Row(
          children: [
            // Resized Glassmorphic Checkbox Hub (Reduced to 28.w)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: isComplete
                    ? ColorManager.primary
                    : ColorManager.primary.withValues(
                        alpha: isDark ? 0.05 : 0.03,
                      ),
                border: Border.all(
                  color: isComplete
                      ? ColorManager.primary
                      : ColorManager.primary.withValues(alpha: 0.1),
                  width: 1.2,
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isComplete
                    ? Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 16.sp,
                        key: const ValueKey('check'),
                      )
                    : const SizedBox.shrink(key: ValueKey('empty')),
              ),
            ),
            horizontalSpace(16),
            Text(
              prayerName.tr(),
              style: TextStyle(
                fontFamily: isComplete ? 'SSTArabicMedium' : 'SSTArabicRoman',
                fontSize: 15
                    .sp, // Adjusted back to 15sp for better fit with small checkbox
                color: isComplete
                    ? ColorManager.primary
                    : (isDark
                          ? Colors.white.withValues(alpha: 0.7)
                          : ColorManager.textMedium),
              ),
            ),
            const Spacer(),
            if (isComplete)
              Text(
                'completed'.tr(),
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 11.sp,
                  color: ColorManager.primary.withValues(alpha: 0.6),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StaggeredItem extends StatelessWidget {
  final int index;
  final Widget child;

  const _StaggeredItem({required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 80)),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
