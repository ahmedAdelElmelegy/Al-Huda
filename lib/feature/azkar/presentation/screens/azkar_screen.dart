import 'package:al_huda/feature/azkar/presentation/screens/azkar_detail_screen.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/azkar_item.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/widgets/default_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DefaultAppBar(title: 'azkar'.tr()),
              verticalSpace(24),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      push(AzkarDetailScreen());
                    },
                    child: AzkarItem(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
