import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:al_huda/feature/azkar/presentation/screens/azkar_detail_screen.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/azkar_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarDetailBody extends StatefulWidget {
  const AzkarDetailBody({super.key, required this.widget});

  final AzkarDetailScreen widget;

  @override
  State<AzkarDetailBody> createState() => _AzkarDetailBodyState();
}

class _AzkarDetailBodyState extends State<AzkarDetailBody> {
  ScrollController scrollController = ScrollController();
  final Map<int, GlobalKey> _itemKeys = {};
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.widget.zikr.length; i++) {
      _itemKeys[i] = GlobalKey();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToNextItem(int currentIndex) {
    if (currentIndex < widget.widget.zikr.length) {
      if (widget.widget.zikr[currentIndex].count > 1) {
        setState(() {
          widget.widget.zikr[currentIndex].count--;
        });
      } else {
        if (currentIndex < widget.widget.zikr.length - 1) {
          setState(() {
            widget.widget.zikr[currentIndex].count = 0;
            _currentIndex = currentIndex + 1;
          });

          WidgetsBinding.instance.addPostFrameCallback((_) {
            final key = _itemKeys[_currentIndex];
            if (key != null && key.currentContext != null) {
              Scrollable.ensureVisible(
                key.currentContext!,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(24),

              isLandscape
                  ? AzkarGridView(
                      zikr: widget.widget.zikr,
                      index: widget.widget.index,
                      onCountComplete: _scrollToNextItem,
                      itemKeys: _itemKeys,
                    )
                  : AzkarListView(
                      zikr: widget.widget.zikr,
                      index: widget.widget.index,
                      onCountComplete: _scrollToNextItem,
                      itemKeys: _itemKeys,
                    ),
              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}

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

class AzkarGridView extends StatelessWidget {
  final List<Zikr> zikr;
  final int index;
  final Function(int) onCountComplete;
  final Map<int, GlobalKey> itemKeys;
  const AzkarGridView({
    super.key,
    required this.zikr,
    required this.index,
    required this.onCountComplete,
    required this.itemKeys,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: zikr.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 1,
      ),
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
