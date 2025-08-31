import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class CustomAppBarWithArrow extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String? icon;
  final bool iSactions;
  final VoidCallback? onPressed;
  const CustomAppBarWithArrow({
    super.key,
    required this.title,
    this.icon,
    this.iSactions = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: ColorManager.primary),
        onPressed: () {
          pop();
        },
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? SvgIcon(assetName: icon!, color: ColorManager.primary)
              : SizedBox(),
          icon != null ? horizontalSpace(8) : SizedBox(),
          Text(
            title,
            style: TextSTyle.f18SSTArabicMediumPrimary.copyWith(
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
      actions: iSactions
          ? [
              IconButton(
                icon: Icon(Icons.alarm, color: ColorManager.primary),
                onPressed: onPressed,
              ),
              horizontalSpace(16),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
