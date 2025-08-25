import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/azkar/presentation/manager/cubit/azkar_cubit.dart';
import 'package:al_huda/feature/azkar/presentation/screens/azkar_detail_screen.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/azkar_item.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/widgets/default_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: ColorManager.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              DefaultAppBar(title: 'azkar'.tr()),
              verticalSpace(24),
              BlocBuilder<AzkarCubit, AzkarState>(
                builder: (context, state) {
                  final azkarCategories = context
                      .read<AzkarCubit>()
                      .azkarCategories;
                  if (state is AzkarLoading) {
                    return LoadingListView();
                  } else if (state is AzkarError) {
                    return Center(
                      child: Text(
                        'error'.tr(),
                        style: TextSTyle.f16AmiriBoldPrimary,
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: azkarCategories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          push(
                            AzkarDetailScreen(
                              zikrName: azkarCategories[index].name,
                              zikr: azkarCategories[index].azkar,
                            ),
                          );
                        },
                        child: AzkarItem(category: azkarCategories[index]),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
