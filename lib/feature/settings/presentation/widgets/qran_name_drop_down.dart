import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/qran/data/model/qran_reader_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReaderNameDropDown extends StatelessWidget {
  final QuranReaderModel? selectedReader;
  final Function(QuranReaderModel?) onChanged;
  const ReaderNameDropDown({
    super.key,
    required this.onChanged,
    this.selectedReader,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('select_reader'.tr(), style: TextSTyle.f12SSTArabicRegBlack),
        verticalSpace(8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: ColorManager.primary),
          ),
          child: DropdownButtonFormField(
            borderRadius: BorderRadius.circular(12.r),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextSTyle.f14SSTArabicMediumPrimary,
              fillColor: ColorManager.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
            ),
            hint: Row(
              children: [
                SvgIcon(assetName: AppIcons.qranA),
                horizontalSpace(4),
                Text('select_reader'.tr()),
              ],
            ),
            value: selectedReader,

            items: Constants.quranReader
                .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                .toList(),
            onChanged: (value) {
              onChanged(value);
            },
          ),
        ),
      ],
    );
  }
}
