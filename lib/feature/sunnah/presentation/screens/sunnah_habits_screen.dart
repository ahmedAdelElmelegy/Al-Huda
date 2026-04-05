import 'package:al_huda/core/helper/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:al_huda/core/di/injection.dart';
import 'package:al_huda/core/theme/colors.dart';
import '../manager/sunnah_cubit.dart';
import '../../data/model/sunnah_habit.dart';

class SunnahHabitsScreen extends StatelessWidget {
  const SunnahHabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider(
      create: (context) => getIt<SunnahCubit>()..getHabits(),
      child: Scaffold(
        backgroundColor: isDark
            ? ColorManager.backgroundDark
            : ColorManager.background,
        appBar: AppBar(
          title: Text(
            'sunnah_habits'.tr(),
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
        body: const SunnahHabitsBody(),
      ),
    );
  }
}

class SunnahHabitsBody extends StatefulWidget {
  const SunnahHabitsBody({super.key});

  @override
  State<SunnahHabitsBody> createState() => _SunnahHabitsBodyState();
}

class _SunnahHabitsBodyState extends State<SunnahHabitsBody> {
  String selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCategoryFilter(),
        Expanded(
          child: BlocBuilder<SunnahCubit, SunnahState>(
            builder: (context, state) {
              if (state is SunnahLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: ColorManager.primary),
                );
              } else if (state is SunnahLoaded) {
                final filteredHabits = selectedCategory == 'all'
                    ? state.habits
                    : state.habits
                          .where((h) => h.category == selectedCategory)
                          .toList();

                if (filteredHabits.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 64.sp,
                          color: ColorManager.primary.withValues(alpha: 0.2),
                        ),
                        verticalSpace(16),
                        Text(
                          'no_items_found'.tr(),
                          style: TextStyle(
                            fontFamily: 'SSTArabicMedium',
                            fontSize: 16.sp,
                            color: ColorManager.textLight,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 40.h),
                  itemCount: filteredHabits.length,
                  itemBuilder: (context, index) {
                    final habit = filteredHabits[index];
                    return _buildHabitItem(habit);
                  },
                );
              } else if (state is SunnahError) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(
                      fontFamily: 'SSTArabicMedium',
                      fontSize: 14.sp,
                      color: Colors.red[400],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categories = [
      {'id': 'all', 'name': 'all_category'.tr()},
      {'id': 'prayer', 'name': 'category_prayer'.tr()},
      {'id': 'fasting', 'name': 'category_fasting'.tr()},
      {'id': 'dhikr', 'name': 'category_dhikr'.tr()},
      {'id': 'quran', 'name': 'category_quran'.tr()},
      {'id': 'manners', 'name': 'category_manners'.tr()},
      {'id': 'etiquettes', 'name': 'category_etiquettes'.tr()},
    ];

    return Container(
      height: 64.h,
      margin: EdgeInsets.symmetric(vertical: 12.h),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = selectedCategory == cat['id'];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = cat['id']!),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [ColorManager.primary, Color(0xFF009688)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isSelected
                    ? null
                    : (isDark ? ColorManager.surfaceDark : Colors.white),
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: ColorManager.primary.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : ColorManager.primary.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                cat['name']!,
                style: TextStyle(
                  fontFamily: isSelected ? 'SSTArabicMedium' : 'SSTArabicRoman',
                  fontSize: 14.sp,
                  color: isSelected ? Colors.white : ColorManager.primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHabitItem(SunnahHabit habit) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isArabic =
        easy.EasyLocalization.of(context)!.locale.languageCode == 'ar';
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        title: Text(
          isArabic ? habit.titleAr : habit.titleEn,
          style: TextStyle(
            fontFamily: 'SSTArabicMedium',
            fontSize: 16.sp,
            color: isDark ? Colors.white : ColorManager.textHigh,
          ),
        ),
        subtitle: habit.streak > 0
            ? Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.local_fire_department_rounded,
                        color: Colors.orange,
                        size: 14.sp,
                      ),
                    ),
                    horizontalSpace(6),
                    Text(
                      '${'streak'.tr()}: ${habit.streak}',
                      style: TextStyle(
                        fontFamily: 'SSTArabicMedium',
                        fontSize: 12.sp,
                        color: ColorManager.primary,
                      ),
                    ),
                  ],
                ),
              )
            : null,
        trailing: Container(
          decoration: BoxDecoration(
            color: habit.isCompleted
                ? ColorManager.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Transform.scale(
            scale: 1.1,
            child: Checkbox(
              value: habit.isCompleted,
              activeColor: ColorManager.primary,
              checkColor: Colors.white,
              side: BorderSide(
                color: ColorManager.primary.withValues(alpha: 0.4),
                width: 1.5,
              ),
              shape: const CircleBorder(),
              onChanged: (val) {
                context.read<SunnahCubit>().toggleHabit(habit.id);
              },
            ),
          ),
        ),
      ),
    );
  }
}
