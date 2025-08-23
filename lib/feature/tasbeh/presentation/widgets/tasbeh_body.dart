import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/tasbeh/presentation/manager/tasbeh/tasbeh_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasbehBody extends StatefulWidget {
  const TasbehBody({super.key});

  @override
  State<TasbehBody> createState() => _TasbehBodyState();
}

class _TasbehBodyState extends State<TasbehBody> {
  @override
  void initState() {
    final cubit = context.read<TasbehCubit>();
    cubit.getTasbehByIndex(cubit.currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasbehCubit, TasbehState>(
      builder: (context, state) {
        final cubit = context.read<TasbehCubit>();
        if (state is TasbehGetByIndexLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TasbehGetByIndexFailure) {
          return Center(child: Text(state.message));
        }
        return Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              cubit.incrementTasbeh();
            },
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cubit.currentTasbeh!.name,
                    style: TextSTyle.f18CairoBoldWhite,
                  ),
                  verticalSpace(36),
                  Text(
                    cubit.currentTasbeh!.count.toString(),
                    style: TextSTyle.f24CairoSemiBoldPrimary.copyWith(
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
