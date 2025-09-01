import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/favorite/presentation/manager/cubit/favorite_cubit.dart';
import 'package:al_huda/feature/favorite/presentation/widgets/favorite_azkar_list.dart';
import 'package:al_huda/feature/favorite/presentation/widgets/favorite_doaa_list.dart';
import 'package:flutter/material.dart';

class SelectContent extends StatelessWidget {
  final int index;
  final FavoriteCubit cubit;
  const SelectContent({super.key, required this.index, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return index == 0
        ? FavoriteAzkarList(zikrList: cubit.zikrList)
        : FavoriteDoaaList(
            key: ValueKey(Constants.doaaNameList[index - 1]),
            category: Constants.doaaNameList[index - 1],
          );
  }
}
