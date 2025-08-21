import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomAppBarWithArrow extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: ColorManager.primary),
        onPressed: () {
          pop();
        },
      ),
      title: Text('prayer_time'.tr(), style: TextSTyle.f18CairoSemiBoldPrimary),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
