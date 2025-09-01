import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/azkar/presentation/manager/cubit/azkar_cubit.dart';
import 'package:al_huda/feature/favorite/presentation/widgets/favorite_azkar_list.dart';
import 'package:al_huda/feature/favorite/presentation/widgets/favorite_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AzkarCubit>().getAllZikr();
  }

  static List<String> favoriteBtnTitle = ['azkar', 'allah_name'];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: 'favorite'.tr()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<AzkarCubit, AzkarState>(
            builder: (context, state) {
              final cubit = context.read<AzkarCubit>();
              if (state is AzkarGetAllLoading) {
                return LoadingListView();
              } else if (state is AzkarGetAllError) {
                return Center(child: Text('error'.tr()));
              }
              if (cubit.zikrList.isEmpty) {
                return Center(child: Image.asset(AppImages.noAzkarFav));
              }
              return Column(
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
                  FavoriteAzkarList(zikrList: cubit.zikrList),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
