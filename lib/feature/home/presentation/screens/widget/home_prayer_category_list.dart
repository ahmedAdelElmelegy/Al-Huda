import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_category_item.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePrayerCategoryLIst extends StatelessWidget {
  const HomePrayerCategoryLIst({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return DynamicHeightGridView(
      shrinkWrap: true,
      mainAxisSpacing: 16.w,
      physics: const NeverScrollableScrollPhysics(),
      builder: (context, index) {
        return InkWell(
          onTap: () {
            push(Constants.homePrayerCategory[index].screen!);
          },
          child: HomeCategoryItem(prayer: Constants.homePrayerCategory[index]),
        );
      },
      itemCount: Constants.homePrayerCategory.length,
      crossAxisCount: isLandScape ? 8 : 4,
    );
  }
}
