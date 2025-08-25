import 'package:al_huda/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingListView extends StatelessWidget {
  const LoadingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
          child: LoadingWidget(height: 60.h),
        );
      },
    );
  }
}
