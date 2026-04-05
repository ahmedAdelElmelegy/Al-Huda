import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/style.dart';
import '../manager/ramadan_cubit.dart';
import '../manager/ramadan_state.dart';

class RamadanScreen extends StatefulWidget {
  const RamadanScreen({super.key});

  @override
  State<RamadanScreen> createState() => _RamadanScreenState();
}

class _RamadanScreenState extends State<RamadanScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RamadanCubit>().loadRamadanData();
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: ColorManager.primaryBg,
      appBar: AppBar(
        title: Text('ramadan_portal'.tr(), style: TextSTyle.f18CairoBoldWhite),
        backgroundColor: ColorManager.primary,
        iconTheme: const IconThemeData(color: ColorManager.white),
        actions: [
          BlocBuilder<RamadanCubit, RamadanState>(
            builder: (context, state) {
              if (state is RamadanLoaded) {
                return Container(
                  margin: EdgeInsetsDirectional.only(end: 16.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: ColorManager.white,
                        size: 16,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${state.fastingDays} ${'day_label'.tr()}',
                        style: TextSTyle.f12CairoSemiBoldWhite,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<RamadanCubit, RamadanState>(
        builder: (context, state) {
          if (state is RamadanLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          } else if (state is RamadanLoaded) {
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              children: [
                _buildImsakiyaCard(state),
                _buildDaySelector(state),
                _buildProgressBar(state),
                _buildTasksList(state, isArabic),
                _buildTipsSection(state, isArabic),
              ],
            );
          } else if (state is RamadanError) {
            return Center(
              child: Text(state.message, style: TextSTyle.f16CairoRegBlack),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildImsakiyaCard(RamadanLoaded state) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildImsakiyaItem(
            'imsak_label'.tr(),
            state.imsak,
            Icons.wb_twilight,
          ),
          Container(
            width: 1.w,
            height: 40.h,
            color: ColorManager.white.withValues(alpha: 0.2),
          ),
          _buildImsakiyaItem(
            'iftar_label'.tr(),
            state.iftar,
            Icons.nightlight_round,
          ),
        ],
      ),
    );
  }

  Widget _buildImsakiyaItem(String label, String time, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: ColorManager.white, size: 24.w),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextSTyle.f12CairoSemiBoldWhite.copyWith(
            color: ColorManager.white.withValues(alpha: 0.8),
          ),
        ),
        Text(time, style: TextSTyle.f18CairoBoldWhite),
      ],
    );
  }

  Widget _buildDaySelector(RamadanLoaded state) {
    return Container(
      height: 80.h,
      margin: EdgeInsets.only(bottom: 16.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 30,
        itemBuilder: (context, index) {
          final day = index + 1;
          final isSelected = day == state.selectedDay;
          return GestureDetector(
            onTap: () => context.read<RamadanCubit>().selectDay(day),
            child: Container(
              width: 50.w,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: isSelected ? ColorManager.primary : ColorManager.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'day_label'.tr(),
                    style: TextSTyle.f10CairoRegPrimary.copyWith(
                      color: isSelected
                          ? ColorManager.white.withValues(alpha: 0.7)
                          : ColorManager.gray,
                    ),
                  ),
                  Text(
                    day.toString(),
                    style: TextSTyle.f18CairoMediumBlack.copyWith(
                      color: isSelected
                          ? ColorManager.white
                          : ColorManager.black,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressBar(RamadanLoaded state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'daily_tasks'.tr(),
                style: TextSTyle.f16CairoMediumBlack.copyWith(
                  color: ColorManager.primary,
                ),
              ),
              Text(
                '${state.completedTasks.length} / ${state.data.dailyActions.length}',
                style: TextSTyle.f14CairoSemiBoldPrimary,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: state.progressPercent,
              minHeight: 10.h,
              backgroundColor: ColorManager.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                state.progressPercent == 1.0
                    ? Colors.green
                    : ColorManager.primary,
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildTasksList(RamadanLoaded state, bool isArabic) {
    return Column(
      children: state.data.dailyActions.map((action) {
        final isCompleted = state.completedTasks.contains(action.id);
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: ColorManager.white,
          elevation: 0,
          child: ListTile(
            onTap: () => context.read<RamadanCubit>().toggleAction(action.id),
            leading: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: isCompleted
                    ? Colors.green.withValues(alpha: 0.1)
                    : ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIconData(action.icon),
                color: isCompleted ? Colors.green : ColorManager.primary,
                size: 20.w,
              ),
            ),
            title: Text(
              action.getTitle(isArabic),
              style: TextSTyle.f14CairoSemiBoldPrimary.copyWith(
                color: isCompleted ? ColorManager.gray : ColorManager.black,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              action.getContent(isArabic),
              style: TextSTyle.f12CairoRegGrey.copyWith(
                color: isCompleted
                    ? ColorManager.gray.withValues(alpha: 0.6)
                    : ColorManager.gray,
              ),
            ),
            trailing: Icon(
              isCompleted ? Icons.check_circle : Icons.check_circle_outline,
              color: isCompleted
                  ? Colors.green
                  : ColorManager.gray.withValues(alpha: 0.5),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTipsSection(RamadanLoaded state, bool isArabic) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Text(
            'ramadan_tips'.tr(),
            style: TextSTyle.f16CairoMediumBlack.copyWith(
              color: ColorManager.primary,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: state.data.tips.map((tip) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  tip.getTip(isArabic),
                  style: TextSTyle.f12CairoRegGrey.copyWith(
                    color: ColorManager.primaryText2,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'restaurant':
        return Icons.restaurant;
      case 'wb_twilight':
        return Icons.wb_twilight;
      case 'nightlight_round':
        return Icons.nightlight_round;
      case 'mosque':
        return Icons.mosque;
      case 'menu_book':
        return Icons.menu_book;
      case 'volunteer_activism':
        return Icons.volunteer_activism;
      case 'auto_awesome':
        return Icons.auto_awesome;
      default:
        return Icons.star;
    }
  }
}
