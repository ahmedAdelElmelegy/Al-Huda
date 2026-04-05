import 'package:al_huda/core/helper/spacing.dart' as spacing;
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
    cubit.getTasbeh(); // Load all data including stats
    cubit.getTasbehByIndex(cubit.currentIndex);
    super.initState();
  }

  void _showMilestoneDialog(int count) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("مبارك!", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.park, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text(
              "لقد قمت بزراعة نخلة جديدة في الجنة!\nإجمالي الأشجار: $count",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("ما شاء الله"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasbehCubit, TasbehState>(
      listener: (context, state) {
        if (state is TasbehMilestoneReached) {
          _showMilestoneDialog(state.totalTrees);
        }
      },
      builder: (context, state) {
        final cubit = context.read<TasbehCubit>();
        if (state is TasbehGetByIndexLoading || state is TasbehLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TasbehGetByIndexFailure) {
          return Center(child: Text(state.message));
        }

        final progress = (cubit.totalTasbeeh % 100) / 100.0;

        return Expanded(
          child: Column(
            children: [
              // Jannah Trees Counter
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.park, color: Colors.green, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      "${cubit.treesPlanted} شجرة في الجنة",
                      style: TextSTyle.f14SSTArabicBoldWhite,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Progress to next tree
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: ColorManager.white.withValues(alpha: 0.1),
                        color: Colors.green,
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "متبقي ${100 - (cubit.totalTasbeeh % 100)} تسبيحة لنخلة جديدة",
                      style: TextSTyle.f12CairoRegGrey.copyWith(
                        color: ColorManager.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
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
                          cubit.currentTasbeh?.name ?? "",
                          style: TextSTyle.f18CairoBoldWhite,
                          textAlign: TextAlign.center,
                        ),
                        spacing.verticalSpace(36),
                        Text(
                          cubit.currentTasbeh?.count.toString() ?? "0",
                          style: TextSTyle.f24CairoSemiBoldPrimary.copyWith(
                            color: ColorManager.white,
                            fontSize: 60, // Larger font for counter
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
