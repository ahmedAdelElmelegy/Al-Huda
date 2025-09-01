import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/azkar_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteAzkarList extends StatelessWidget {
  final List<Zikr> zikrList;
  const FavoriteAzkarList({super.key, required this.zikrList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: zikrList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AzkarDetailItem(
            index: index + 1,
            zikr: zikrList[index],
            isFav: true,
            zikrIndex: index,
          ),
        );
      },
    );
  }
}
