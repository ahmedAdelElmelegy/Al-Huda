import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/tasbeh/data/model/tasbeh_model.dart';
import 'package:al_huda/feature/tasbeh/presentation/manager/tasbeh/tasbeh_cubit.dart';
import 'package:al_huda/feature/tasbeh/presentation/widgets/tasbeh_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewTaskbeh extends StatelessWidget {
  const AddNewTaskbeh({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasbehCubit, TasbehState>(
      builder: (context, state) {
        final cubit = context.read<TasbehCubit>();
        return cubit.isEdit
            ? GestureDetector(
                onTap: () {
                  cubit.changeEditState();
                },
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundColor: ColorManager.blue,
                  child: SvgIcon(
                    assetName: AppIcons.edit,
                    color: ColorManager.white,
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
              )
            : InkWell(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              key: cubit.formKey,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 8.h,
                                ),
                                child: TextFormField(
                                  controller: cubit.zekrController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'add_zekr'.tr(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'add_zekr'.tr();
                                    }
                                    return null;
                                  },
                                  maxLines: 4,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TasbehBtn(
                                    onPressed: () {
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.addTasbeh(
                                          TasbehModel(
                                            name: cubit.zekrController.text,
                                            lock: false,
                                            count: 0,
                                          ),
                                        );
                                      }
                                    },
                                    radiusDirection: true,
                                    text: 'save'.tr(),
                                    color: ColorManager.blue,
                                  ),
                                ),
                                Expanded(
                                  child: TasbehBtn(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    radiusDirection: false,
                                    text: 'cancel'.tr(),
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: SvgIcon(
                  assetName: AppIcons.add,
                  color: ColorManager.white,
                  width: 20.w,
                  height: 20.h,
                ),
              );
      },
    );
  }
}
