import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/doaa/presentation/widgets/doaa_item.dart';
import 'package:al_huda/feature/favorite/presentation/manager/cubit/favorite_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteDoaaList extends StatefulWidget {
  final String category;
  const FavoriteDoaaList({super.key, required this.category});

  @override
  State<FavoriteDoaaList> createState() => _FavoriteDoaaListState();
}

class _FavoriteDoaaListState extends State<FavoriteDoaaList> {
  @override
  void initState() {
    super.initState();
    _fetchDoaa();
  }

  @override
  void didUpdateWidget(covariant FavoriteDoaaList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      _fetchDoaa();
    }
  }

  void _fetchDoaa() {
    context.read<FavoriteCubit>().getDoaaByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final cubit = context.read<FavoriteCubit>();

        if (state is FavoriteGetDoaaByCategoryLoading) {
          return LoadingListView();
        } else if (state is FavoriteGetDoaaByCategoryError) {
          return Center(child: Text('error'.tr()));
        }

        if (cubit.doaaList.isEmpty) {
          return Center(
            child: Image.asset(
              AppImages.noAzkarFav,
              width: isLandScape ? 200.w : double.infinity,
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cubit.doaaList.length,
          itemBuilder: (context, index) {
            return DoaaItem(doaaModelData: cubit.doaaList[index], index: index);
          },
        );
      },
    );
  }
}
