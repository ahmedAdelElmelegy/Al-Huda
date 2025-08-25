import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/qran/presentation/manager/Surah/qran_cubit.dart';
import 'package:al_huda/feature/qran/presentation/screens/ayat_screen.dart';
import 'package:al_huda/feature/qran/presentation/widgets/sura_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurahListView extends StatelessWidget {
  const SurahListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QranCubit, QranState>(
      builder: (context, state) {
        if (state is QranLoading) {
          return LoadingListView();
        }

        final cubit = context.read<QranCubit>();

        if (state is QranError) {
          return Center(child: Text(state.message));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cubit.surahList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                push(AyatScreen(surahData: cubit.surahList[index]));
              },
              child: SurahItem(surahData: cubit.surahList[index]),
            );
          },
        );
      },
    );
  }
}
