import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/family/data/model/family_member.dart';
import 'package:al_huda/feature/family/presentation/manager/family_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final _nameController = TextEditingController();
  String _selectedRole = "ابن";
  final List<String> _roles = [
    "أب",
    "أم",
    "ابن",
    "ابنة",
    "جد",
    "جدة",
    "أخ",
    "أخت",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? ColorManager.backgroundDark
          : ColorManager.background,
      appBar: AppBar(
        title: Text(
          "إضافة عضو جديد",
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
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "اسم العضو",
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 16.sp,
                color: ColorManager.primary,
              ),
            ),
            verticalSpace(12),
            TextField(
              controller: _nameController,
              style: TextStyle(fontFamily: 'SSTArabicRoman', fontSize: 16.sp),
              decoration: InputDecoration(
                hintText: "مثال: أحمد",
                hintStyle: TextStyle(
                  fontFamily: 'SSTArabicRoman',
                  color: ColorManager.textLight,
                ),
                filled: true,
                fillColor: isDark ? ColorManager.surfaceDark : Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 18.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: const BorderSide(
                    color: ColorManager.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            verticalSpace(32),
            Text(
              "الدور / الصلة",
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 16.sp,
                color: ColorManager.primary,
              ),
            ),
            verticalSpace(12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isDark ? ColorManager.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedRole,
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: ColorManager.primary,
                  ),
                  dropdownColor: isDark
                      ? ColorManager.surfaceDark
                      : Colors.white,
                  items: _roles.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontFamily: 'SSTArabicRoman',
                          fontSize: 16.sp,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue!;
                    });
                  },
                ),
              ),
            ),
            verticalSpace(60),
            Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.primary.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty) {
                    final member = FamilyMember(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _nameController.text,
                      role: _selectedRole,
                    );
                    context.read<FamilyCubit>().addMember(member);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "إضافة العضو",
                  style: TextStyle(
                    fontFamily: 'SSTArabicMedium',
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

SizedBox verticalSpace(double height) => SizedBox(height: height.h);
SizedBox horizontalSpace(double width) => SizedBox(width: width.w);
