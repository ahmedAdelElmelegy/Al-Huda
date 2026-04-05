import 'package:al_huda/core/helper/spacing.dart' hide verticalSpace;
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/family/presentation/manager/family_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_member_screen.dart' hide horizontalSpace;

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  @override
  void initState() {
    context.read<FamilyCubit>().getMembers();
    super.initState();
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
          "وضع العائلة",
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
      body: BlocBuilder<FamilyCubit, FamilyState>(
        builder: (context, state) {
          if (state is FamilyLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          } else if (state is FamilyFailure) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 16.sp,
                  color: ColorManager.textHigh,
                ),
              ),
            );
          } else if (state is FamilySuccess) {
            if (state.members.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(32.r),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.family_restroom_rounded,
                        size: 64.sp,
                        color: ColorManager.primary,
                      ),
                    ),
                    verticalSpace(24),
                    Text(
                      "لا يوجد أعضاء مضافون بعد",
                      style: TextStyle(
                        fontFamily: 'SSTArabicMedium',
                        fontSize: 18.sp,
                        color: ColorManager.textHigh,
                      ),
                    ),
                    verticalSpace(8),
                    Text(
                      "أضف أفراد عائلتك لمتابعة نشاطهم",
                      style: TextStyle(
                        fontFamily: 'SSTArabicRoman',
                        fontSize: 14.sp,
                        color: ColorManager.textLight,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 100.h),
              physics: const BouncingScrollPhysics(),
              itemCount: state.members.length,
              itemBuilder: (context, index) {
                final member = state.members[index];
                return _buildMemberCard(context, member, index);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddMemberScreen()),
            );
          },
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Icon(
            Icons.person_add_rounded,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildMemberCard(BuildContext context, dynamic member, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  _getRoleIcon(member.role),
                  color: ColorManager.primary,
                  size: 28.sp,
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: TextStyle(
                        fontFamily: 'SSTArabicMedium',
                        fontSize: 16.sp,
                        color: isDark ? Colors.white : ColorManager.textHigh,
                      ),
                    ),
                    Text(
                      member.role,
                      style: TextStyle(
                        fontFamily: 'SSTArabicRoman',
                        fontSize: 13.sp,
                        color: ColorManager.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_sweep_rounded,
                  color: Colors.red[400],
                  size: 22.sp,
                ),
                onPressed: () {
                  context.read<FamilyCubit>().deleteMember(index);
                },
              ),
            ],
          ),
          verticalSpace(20),
          Container(
            height: 1,
            color: ColorManager.primary.withValues(alpha: 0.05),
          ),
          verticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                "الصلوات",
                member.prayersCount,
                Icons.timer_rounded,
              ),
              _buildStatItem(
                "القرآن",
                member.quranPagesCount,
                Icons.auto_stories_rounded,
              ),
              _buildStatItem(
                "الأذكار",
                member.azkarCount,
                Icons.favorite_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: ColorManager.primary.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20.sp, color: ColorManager.primary),
        ),
        verticalSpace(8),
        Text(
          count.toString(),
          style: TextStyle(
            fontFamily: 'SSTArabicMedium',
            fontSize: 16.sp,
            color: ColorManager.primary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'SSTArabicRoman',
            fontSize: 11.sp,
            color: ColorManager.textLight,
          ),
        ),
      ],
    );
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case "أب":
      case "Father":
        return Icons.person_rounded;
      case "أم":
      case "Mother":
        return Icons.person_3_rounded;
      case "ابن":
      case "Son":
        return Icons.child_care_rounded;
      case "ابنة":
      case "Daughter":
        return Icons.face_3_rounded;
      default:
        return Icons.person_outline_rounded;
    }
  }
}
