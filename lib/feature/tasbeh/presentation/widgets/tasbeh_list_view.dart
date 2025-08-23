import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/feature/tasbeh/presentation/manager/tasbeh/tasbeh_cubit.dart';
import 'package:al_huda/feature/tasbeh/presentation/widgets/tasbeh_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasbehListView extends StatefulWidget {
  const TasbehListView({super.key});

  @override
  State<TasbehListView> createState() => _TasbehListViewState();
}

class _TasbehListViewState extends State<TasbehListView> {
  @override
  void initState() {
    context.read<TasbehCubit>().getTasbeh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasbehCubit, TasbehState>(
      builder: (context, state) {
        final cubit = context.read<TasbehCubit>();
        if (state is TasbehLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TasbehFailure) {
          return Center(child: Text(state.message));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cubit.tasbehList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (cubit.isEdit) {
                    cubit.getTasbehByIndex(index);
                    pop();
                  }
                },

                child: TasbehItem(
                  index: index,
                  isSelected: cubit.currentIndex == index,
                  tasbeh: cubit.tasbehList[index],
                ),
              );
            },
          );
        }
      },
    );
  }
}
//  showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text('delete_zekr'.tr()),
//                         content: Text('are_you_sure'.tr()),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               pop();
//                             },
//                             child: Text('cancel'.tr()),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               cubit.deleteTasbeh(index);
//                             },
//                             child: Text('delete'.tr()),
//                           ),
//                         ],
//                       );
//                     },
//                   );