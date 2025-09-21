import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/prayer_time/presentation/screens/setting_prayer_time_screen.dart';
import 'package:al_huda/feature/settings/presentation/screens/setting_azkar_screen.dart';
import 'package:al_huda/feature/settings/presentation/screens/qran_setting_screen.dart';
import 'package:al_huda/feature/settings/presentation/widgets/setting_action_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreenAction extends StatelessWidget {
  const SettingScreenAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            push(SettingPrayerTimeScreen());
          },
          child: SettingActionBtn(title: 'prayers_time'.tr()),
        ),
        verticalSpace(16),
        InkWell(
          onTap: () {
            push(QranSettingScreen());
          },
          child: SettingActionBtn(title: 'qran_setting'.tr()),
        ),
        verticalSpace(16),
        InkWell(
          onTap: () {
            push(SettingAzkarScreen());
          },
          child: SettingActionBtn(title: 'azkar_setting'.tr()),
        ),
        verticalSpace(16),
        InkWell(
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              builder: (context) {
                return LanguageDialog();
              },
            );
          },
          child: SettingActionBtn(title: 'language'.tr()),
        ),
        verticalSpace(16),
        SettingActionBtn(
          title: 'app_version'.tr(),
          child: Row(
            children: [
              Text(
                '1.0.0 ${tr('version')}',
                style: TextSTyle.f14CairoRegularPrimary.copyWith(
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 36.h),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.r),
          topRight: Radius.circular(50.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('language'.tr(), style: TextSTyle.f24SSTArabicMediumPrimary),
          verticalSpace(16),
          Divider(color: ColorManager.gray.withValues(alpha: 0.2)),
          verticalSpace(16),
          LangCheckBoxList(),
        ],
      ),
    );
  }
}

class LangCheckBoxList extends StatefulWidget {
  const LangCheckBoxList({super.key});

  @override
  State<LangCheckBoxList> createState() => _LangCheckBoxListState();
}

class _LangCheckBoxListState extends State<LangCheckBoxList> {
  final Map<String, Locale> languages = {
    'ar': const Locale('ar', 'EG'),
    'en': const Locale('en', 'US'),
  };

  @override
  void initState() {
    super.initState();
    _getCurrentLanguage();
  }

  String selectedLanguage = 'ar';
  Future<void> _getCurrentLanguage() async {
    String lang = await SharedPrefServices.getValue(Constants.language) ?? 'ar';
    setState(() {
      selectedLanguage = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...languages.keys.map(
          (lang) => LangCheckBoxItem(
            lang: lang == 'ar' ? 'arabic'.tr() : 'english'.tr(),
            value: lang,
            groupValue: selectedLanguage,
            onChanged: (value) {
              setState(() => selectedLanguage = value);
            },
          ),
        ),
        verticalSpace(24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 48.h),
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          onPressed: () {
            EasyLocalization.of(
              context,
            )!.setLocale(languages[selectedLanguage]!);
            SharedPrefServices.setValue(selectedLanguage, Constants.language);
            Navigator.pop(context);
          },
          child: Text(
            'save'.tr(),
            style: TextSTyle.f14CairoSemiBoldPrimary.copyWith(
              color: ColorManager.white,
            ),
          ),
        ),
      ],
    );
  }
}

class LangCheckBoxItem extends StatelessWidget {
  final String lang;
  final String value;
  final String groupValue;
  final Function onChanged;
  const LangCheckBoxItem({
    super.key,
    required this.lang,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (value) {
            onChanged(value);
          },
        ),
        Text(lang, style: TextSTyle.f14CairoRegularPrimary),
      ],
    );
  }
}
