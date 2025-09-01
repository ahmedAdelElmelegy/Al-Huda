import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/azkar_detail_item.dart';
import 'package:flutter/material.dart';

class AzkarListView extends StatelessWidget {
  final List<Zikr> zikr;
  final int index;
  final Function(int) onCountComplete;
  final Map<int, GlobalKey> itemKeys;
  const AzkarListView({
    super.key,
    required this.zikr,
    required this.index,
    required this.onCountComplete,
    required this.itemKeys,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: zikr.length,
      itemBuilder: (context, index) {
        return AzkarDetailItem(
          index: index + 1,
          key: itemKeys[index],
          zikr: zikr[index],
          onCountComplete: () {
            onCountComplete(index);
          },
        );
      },
    );
  }
}
