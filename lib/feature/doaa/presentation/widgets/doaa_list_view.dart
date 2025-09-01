import 'package:al_huda/feature/doaa/presentation/manager/cubit/doaa_cubit.dart';
import 'package:al_huda/feature/doaa/presentation/widgets/doaa_detail_screen.dart';
import 'package:al_huda/feature/doaa/presentation/widgets/doaa_item.dart';
import 'package:flutter/material.dart';

class DoaaListView extends StatelessWidget {
  const DoaaListView({super.key, required this.cubit, required this.widget});

  final DoaaCubit cubit;
  final DoaaDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: cubit.doaaList.length,
      itemBuilder: (context, index) {
        return DoaaItem(
          doaaHeaderIndex: widget.doaaHeaderindex,
          doaaModelData: cubit.doaaList[index],
          index: index,
        );
      },
    );
  }
}
