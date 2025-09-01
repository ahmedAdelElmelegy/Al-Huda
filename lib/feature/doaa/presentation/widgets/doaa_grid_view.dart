import 'package:al_huda/feature/doaa/presentation/manager/cubit/doaa_cubit.dart';
import 'package:al_huda/feature/doaa/presentation/widgets/doaa_detail_screen.dart';
import 'package:al_huda/feature/doaa/presentation/widgets/doaa_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoaaGridView extends StatelessWidget {
  const DoaaGridView({super.key, required this.cubit, required this.widget});
  final DoaaCubit cubit;
  final DoaaDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        return DoaaItem(
          doaaHeaderIndex: widget.doaaHeaderindex,
          doaaModelData: cubit.doaaList[index],
          index: index,
        );
      },
      itemCount: cubit.doaaList.length,
    );
  }
}
