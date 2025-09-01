import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/widgets/loading_list_view.dart';

import 'package:al_huda/feature/doaa/presentation/manager/cubit/doaa_cubit.dart';
import 'package:al_huda/feature/doaa/presentation/widgets/clear_app_bar.dart';
import 'package:al_huda/feature/doaa/presentation/widgets/doaa_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoaaDetailsScreen extends StatefulWidget {
  final String title;
  final String data;
  final int doaaHeaderindex;
  const DoaaDetailsScreen({
    super.key,
    required this.title,
    required this.data,
    required this.doaaHeaderindex,
  });

  @override
  State<DoaaDetailsScreen> createState() => _DoaaDetailsScreenState();
}

class _DoaaDetailsScreenState extends State<DoaaDetailsScreen> {
  @override
  void initState() {
    context.read<DoaaCubit>().getDoaaList(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                ClearAppBar(title: widget.title),
                verticalSpace(24),
                BlocBuilder<DoaaCubit, DoaaState>(
                  builder: (context, state) {
                    final cubit = context.read<DoaaCubit>();
                    if (state is DoaaLoading) {
                      return LoadingListView();
                    } else if (state is DoaaError) {
                      return Center(child: Text(state.message));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cubit.doaaList.length,
                      itemBuilder: (context, index) {
                        return DoaaItem(
                          doaaHeaderIndex: widget.doaaHeaderindex,
                          doaaModelData: cubit.doaaList[index],
                          index: index,
                        );
                      },
                    );
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
