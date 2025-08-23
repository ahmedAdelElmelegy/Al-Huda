import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:flutter/material.dart';

class CustomAppBarWithArrow extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const CustomAppBarWithArrow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: ColorManager.primary),
        onPressed: () {
          pop();
        },
      ),
      title: Text(title, style: TextSTyle.f18CairoSemiBoldPrimary),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
