import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';
import 'package:al_huda/feature/radio/presentation/manager/cubit/radio_cubit.dart';
import 'package:al_huda/feature/radio/presentation/screens/radio_detail_screen.dart';
import 'package:al_huda/feature/radio/presentation/widgets/radio_reader_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RadioReaderListView extends StatelessWidget {
  const RadioReaderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioCubit, RadioState>(
      builder: (context, state) {
        final cubit = context.read<RadioCubit>();
        if (state is RadioLoading) {
          return LoadingListView();
        }
        if (state is RadioError) {
          return Center(child: Text(state.message));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              push(
                RadioDetailScreen(
                  radioData: cubit.radioList[index],
                  radioList: cubit.radioList,
                ),
              );
            },
            child: RadioReaderItem(
              radioData: cubit.radioList[index],
              radioList: cubit.radioList,
            ),
          ),
          itemCount: cubit.radioList.length,
        );
      },
    );
  }
}
