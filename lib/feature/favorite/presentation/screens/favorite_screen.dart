import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/favorite/presentation/manager/cubit/favorite_cubit.dart';
import 'package:al_huda/feature/favorite/presentation/widgets/favorite_btn.dart';
import 'package:al_huda/feature/favorite/presentation/widgets/select_contenent.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().getAllZikr();
  }

  static List<String> favoriteBtnTitle = ['azkar', ...Constants.doaaNameList];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: 'favorite'.tr()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                verticalSpace(16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      favoriteBtnTitle.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          if (index > 0) {
                            context.read<FavoriteCubit>().getDoaaByCategory(
                              Constants.doaaNameList[index - 1],
                            );
                          }
                        },
                        child: FavoriteBtn(
                          title: favoriteBtnTitle[index].tr(),
                          selectIndex: selectedIndex == index,
                        ),
                      ),
                    ),
                  ),
                ),
                verticalSpace(24),
                BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    final cubit = context.read<FavoriteCubit>();
                    if (state is AzkarGetAllLoading) {
                      return LoadingListView();
                    } else if (state is AzkarGetAllError) {
                      return Center(child: Text('error'.tr()));
                    }
                    if (cubit.zikrList.isEmpty && selectedIndex == 0) {
                      return Center(
                        child: Image.asset(
                          AppImages.noAzkarFav,

                          width: isLandScape ? 200.w : double.infinity,
                        ),
                      );
                    }
                    return SelectContent(index: selectedIndex, cubit: cubit);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
