import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/style.dart';
import '../../data/model/hifz_model.dart';
import '../manager/hifz_cubit.dart';
import '../manager/hifz_state.dart';

class HifzDashboardScreen extends StatefulWidget {
  const HifzDashboardScreen({super.key});

  @override
  State<HifzDashboardScreen> createState() => _HifzDashboardScreenState();
}

class _HifzDashboardScreenState extends State<HifzDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HifzCubit>().loadHifzData();
  }

  String _formatDueDate(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final reviewDay = DateTime(date.year, date.month, date.day);

    final difference = reviewDay.difference(today).inDays;

    if (difference <= 0) return 'due_today'.tr();
    if (difference == 1) return 'due_tomorrow'.tr();
    return 'due_in_days'.tr(args: [difference.toString()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryBg,
      appBar: AppBar(
        title: Text('hifz_tracker'.tr(), style: TextSTyle.f18CairoBoldWhite),
        backgroundColor: ColorManager.primary,
        iconTheme: const IconThemeData(color: ColorManager.white),
      ),
      body: BlocBuilder<HifzCubit, HifzState>(
        builder: (context, state) {
          if (state is HifzLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          } else if (state is HifzLoaded) {
            return ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                _buildProgressCard(state),
                SizedBox(height: 24.h),
                _buildDueReviewsHeader(state),
                if (state.dueReviews.isEmpty)
                  _buildEmptyReviews()
                else
                  ...state.dueReviews.map(
                    (verse) => _buildReviewItem(verse, state.surahList),
                  ),
                SizedBox(height: 24.h),
                _buildTotalStats(state),
              ],
            );
          } else if (state is HifzError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildProgressCard(HifzLoaded state) {
    final totalAyahs = state.surahList.fold<int>(
      0,
      (sum, surah) => sum + (surah.numberOfAyahs ?? 0),
    );
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120.w,
                height: 120.w,
                child: CircularProgressIndicator(
                  value: state.totalProgress,
                  strokeWidth: 12,
                  backgroundColor: ColorManager.primary.withValues(alpha: 0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    ColorManager.primary,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    '${(state.totalProgress * 100).toStringAsFixed(1)}%',
                    style: TextSTyle.f24SSTArabicMediumPrimary,
                  ),
                  Text(
                    'memorized_verses'.tr().split(' ')[0],
                    style: TextSTyle.f12CairoRegGrey,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            'total_hifz_progress'.tr(),
            style: TextSTyle.f16SSTArabicMediumBlack,
          ),
          SizedBox(height: 8.h),
          Text(
            '${state.memorizedVerses.length} / $totalAyahs ${'memorized_verses'.tr()}',
            style: TextSTyle.f14CairoBoldPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildDueReviewsHeader(HifzLoaded state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('due_reviews'.tr(), style: TextSTyle.f18CairoSemiBoldPrimary),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: state.dueReviews.isEmpty
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            state.dueReviews.length.toString(),
            style: TextSTyle.f14CairoSemiBoldPrimary.copyWith(
              color: state.dueReviews.isEmpty ? Colors.green : Colors.orange,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyReviews() {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          const Icon(Icons.done_all, color: Colors.green, size: 48),
          SizedBox(height: 12.h),
          Text(
            'review_success'.tr(),
            style: TextSTyle.f16SSTArabicMediumBlack.copyWith(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(HifzVerse verse, List<SurahData> surahList) {
    final surahName =
        surahList
            .firstWhere(
              (s) => s.number == verse.surahIndex,
              orElse: () => SurahData(name: ''),
            )
            .name ??
        '';
    return Card(
      margin: EdgeInsets.only(top: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(
          '$surahName : ${'ayah'.tr()} ${verse.ayahIndex}',
          style: TextSTyle.f14CairoSemiBoldPrimary,
        ),
        subtitle: Text(
          _formatDueDate(verse.nextReviewDate),
          style: TextSTyle.f12CairoRegGrey,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () => context.read<HifzCubit>().markAsReviewed(
                verse.surahIndex,
                verse.ayahIndex,
                false,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () => context.read<HifzCubit>().markAsReviewed(
                verse.surahIndex,
                verse.ayahIndex,
                true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalStats(HifzLoaded state) {
    return Column(
      children: [
        _buildStatTile(
          Icons.history,
          'last_session'.tr(),
          'earlier_today'.tr(),
        ),
        _buildStatTile(
          Icons.trending_up,
          'daily_goal'.tr(),
          '10 ${'ayah'.tr()}',
        ),
      ],
    );
  }

  Widget _buildStatTile(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: ColorManager.primary, size: 24.w),
          SizedBox(width: 16.w),
          Text(
            title,
            style: TextSTyle.f14CairoBoldPrimary.copyWith(
              color: ColorManager.black,
            ),
          ),
          const Spacer(),
          Text(value, style: TextSTyle.f14CairoSemiBoldPrimary),
        ],
      ),
    );
  }
}
