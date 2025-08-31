import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';
import 'package:al_huda/feature/qran/data/model/qran_reader_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QranSettingScreen extends StatefulWidget {
  const QranSettingScreen({super.key});

  @override
  State<QranSettingScreen> createState() => _QranSettingScreenState();
}

class _QranSettingScreenState extends State<QranSettingScreen> {
  QuranReaderModel? selectedReader;

  @override
  void initState() {
    super.initState();
    _getCurrentReader();
  }

  Future<void> _getCurrentReader() async {
    String url =
        await SharedPrefServices.getValue(Constants.reader) ??
        AppURL.readerName;
    selectedReader = Constants.quranReader.firstWhere(
      (element) => element.url == url,
    );
    setState(() {
      selectedReader = Constants.quranReader.firstWhere(
        (element) => element.url == url,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(
        title: 'qran_setting'.tr(),
        // icon: AppIcons.qranA,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              verticalSpace(16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: ColorManager.greyLight2),
                ),
                child: DropdownButtonFormField(
                  borderRadius: BorderRadius.circular(12.r),
                  decoration: InputDecoration(border: InputBorder.none),
                  hint: Text('select_reader'.tr()),
                  value: selectedReader,

                  items: Constants.quranReader
                      .map(
                        (e) => DropdownMenuItem(value: e, child: Text(e.name)),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedReader = value;
                      SharedPrefServices.setValue(value!.url, Constants.reader);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
