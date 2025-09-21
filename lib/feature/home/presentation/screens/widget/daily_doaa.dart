import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/doaa_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/doaa/presentation/manager/cubit/doaa_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyDoaa extends StatefulWidget {
  const DailyDoaa({super.key});

  @override
  State<DailyDoaa> createState() => _DailyDoaaState();
}

class _DailyDoaaState extends State<DailyDoaa> {
  String dailyDoaa = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cubit = context.read<DoaaCubit>();
      cubit.getDoaaList(AppURL.doaaListUrl[0]);
      setState(() {
        dailyDoaa = DoaaServices().getDailyDoaa(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: ColorManager.greyLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('daily_doaa'.tr(), style: TextSTyle.f14CairoBoldPrimary),
          verticalSpace(8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dailyDoaa.isNotEmpty ? dailyDoaa : '...', // لو لسه بجيب الدعاء
              style: TextSTyle.f14SSTArabicMediumPrimary.copyWith(
                color: ColorManager.primary2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
