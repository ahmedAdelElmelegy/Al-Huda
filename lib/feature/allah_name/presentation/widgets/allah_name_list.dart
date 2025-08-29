import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/feature/allah_name/presentation/manager/cubit/allah_name_cubit.dart';
import 'package:al_huda/feature/allah_name/presentation/widgets/allah_name_item.dart';
import 'package:al_huda/feature/allah_name/presentation/widgets/detail_frame.dart';
import 'package:flutter/material.dart';

class AllahNameList extends StatelessWidget {
  const AllahNameList({super.key, required this.cubit});

  final AllahNameCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: cubit.allahNames.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                DetailFrame(name: cubit.allahNames[index].name),
                verticalSpace(48),
                AllahNameItem(
                  index: index + 1,
                  name: cubit.allahNames[index].text,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
