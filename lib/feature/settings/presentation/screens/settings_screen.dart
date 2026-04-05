import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/app.dart';
import 'package:al_huda/feature/prayer_time/presentation/screens/setting_prayer_time_screen.dart';
import 'package:al_huda/feature/settings/presentation/screens/qran_setting_screen.dart';
import 'package:al_huda/feature/settings/presentation/screens/setting_azkar_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? ColorManager.backgroundDark
          : ColorManager.background,
      appBar: AppBar(
        title: Text(
          'settings'.tr(),
          style: TextStyle(
            fontFamily: 'SSTArabicMedium',
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.primary,
        elevation: 4,
        shadowColor: ColorManager.primary.withValues(alpha: 0.2),
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
        children: [
          // ── Prayer ──────────────────────────────────────────────────
          _SettingsGroup(
            icon: Icons.access_time_rounded,
            title: 'prayers_time'.tr(),
            isDark: isDark,
            items: [
              _SettingsTile(
                icon: Icons.tune_rounded,
                iconBg: const Color(0xFF1B6B5A),
                title: 'prayers_time'.tr(),
                subtitle: 'prayer_time'.tr(),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SettingPrayerTimeScreen()),
                ),
              ),
              _SettingsTile(
                icon: Icons.notifications_rounded,
                iconBg: const Color(0xFF2DA882),
                title: 'prayer_notifications'.tr(),
                subtitle: 'notification_prayer'.tr(),
                trailing: _NotificationSwitch(
                  prefKey: '${Constants.keyPrefixNotification}all',
                ),
              ),
            ],
          ),

          verticalSpace(24),

          // ── Quran ───────────────────────────────────────────────────
          _SettingsGroup(
            icon: Icons.menu_book_rounded,
            title: 'quran'.tr(),
            isDark: isDark,
            items: [
              _SettingsTile(
                icon: Icons.settings_suggest_rounded,
                iconBg: const Color(0xFF6A3D9A),
                title: 'qran_setting'.tr(),
                subtitle: 'select_reader'.tr(),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QranSettingScreen()),
                ),
              ),
            ],
          ),

          verticalSpace(24),

          // ── Azkar ───────────────────────────────────────────────────
          _SettingsGroup(
            icon: Icons.spa_rounded,
            title: 'azkar'.tr(),
            isDark: isDark,
            items: [
              _SettingsTile(
                icon: Icons.auto_awesome_rounded,
                iconBg: const Color(0xFF00875A),
                title: 'azkar_setting'.tr(),
                subtitle: 'scedule_zekr_time'.tr(),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingAzkarScreen()),
                ),
              ),
            ],
          ),

          verticalSpace(24),

          // ── App ─────────────────────────────────────────────────────
          _SettingsGroup(
            icon: Icons.settings_rounded,
            title: 'settings'.tr(),
            isDark: isDark,
            items: [
              // Language
              _SettingsTile(
                icon: Icons.language_rounded,
                iconBg: const Color(0xFF1565C0),
                title: 'language'.tr(),
                subtitle: context.locale.languageCode == 'ar'
                    ? 'arabic'.tr()
                    : 'english'.tr(),
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const _LanguageSheet(),
                ),
              ),
              // Dark mode
              _SettingsTile(
                icon: isDark
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
                iconBg: isDark
                    ? const Color(0xFF37474F)
                    : const Color(0xFFF57F17),
                title: 'theme'.tr(),
                subtitle: isDark ? 'dark_mode'.tr() : 'light_mode'.tr(),
                trailing: Switch(
                  value: isDark,
                  activeThumbColor: ColorManager.primary,
                  onChanged: (v) {
                    appThemeMode.value = v ? ThemeMode.dark : ThemeMode.light;
                  },
                ),
              ),
              // About
              _SettingsTile(
                icon: Icons.info_outline_rounded,
                iconBg: const Color(0xFF546E7A),
                title: 'about'.tr(),
                subtitle: '1.0.0 ${'version'.tr()}',
              ),
              // Rate App
              _SettingsTile(
                icon: Icons.star_rounded,
                iconBg: const Color(0xFFF57C00),
                title: 'rate_app'.tr(),
                onTap: () {},
              ),
            ],
          ),

          verticalSpace(32),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> items;
  final bool isDark;

  const _SettingsGroup({
    required this.icon,
    required this.title,
    required this.items,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.h, right: 4.w),
          child: Row(
            children: [
              Container(
                width: 3.w,
                height: 16.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorManager.primary,
                      ColorManager.primary.withValues(alpha: 0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              horizontalSpace(10),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 16.sp,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.9)
                      : ColorManager.textHigh,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? ColorManager.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(32.r),
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: ColorManager.primary.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                items[i],
                if (i < items.length - 1)
                  Divider(
                    height: 1,
                    indent: 68.w,
                    endIndent: 24.w,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.black.withValues(alpha: 0.1),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.iconBg,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: iconBg.withValues(alpha: isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: iconBg.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: isDark ? iconBg.withValues(alpha: 0.9) : iconBg,
                  size: 22.sp,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'SSTArabicMedium',
                      fontSize: 15.sp,
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.95)
                          : ColorManager.textHigh,
                      height: 1.2,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    verticalSpace(4),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontFamily: 'SSTArabicRoman',
                        fontSize: 12.sp,
                        color: ColorManager.textLight.withValues(alpha: 0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            trailing ??
                (onTap != null
                    ? Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 14.sp,
                        color: ColorManager.primary.withValues(alpha: 0.3),
                      )
                    : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}

class _NotificationSwitch extends StatefulWidget {
  final String prefKey;
  const _NotificationSwitch({required this.prefKey});

  @override
  State<_NotificationSwitch> createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<_NotificationSwitch> {
  bool _enabled = true;

  @override
  void initState() {
    super.initState();
    SharedPrefServices.getValue(widget.prefKey).then((v) {
      if (mounted) setState(() => _enabled = v != 'false');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _enabled,
      activeThumbColor: ColorManager.primary,
      onChanged: (v) {
        setState(() => _enabled = v);
        SharedPrefServices.setValue(v ? 'true' : 'false', widget.prefKey);
      },
    );
  }
}

class _LanguageSheet extends StatefulWidget {
  const _LanguageSheet();

  @override
  State<_LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<_LanguageSheet> {
  final Map<String, Locale> _langs = {
    'ar': const Locale('ar', 'EG'),
    'en': const Locale('en', 'US'),
  };
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = 'ar';
    SharedPrefServices.getValue(
      Constants.language,
    ).then((v) => setState(() => _selected = v ?? 'ar'));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? ColorManager.surfaceDark : Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          verticalSpace(24),
          Text(
            'language'.tr(),
            style: TextStyle(
              fontFamily: 'SSTArabicMedium',
              fontSize: 20.sp,
              color: isDark ? Colors.white : ColorManager.textHigh,
            ),
          ),
          verticalSpace(24),
          ..._langs.keys.map(
            (lang) => _LanguageItem(
              label: lang == 'ar' ? 'arabic'.tr() : 'english'.tr(),
              isSelected: _selected == lang,
              onTap: () => setState(() => _selected = lang),
            ),
          ),
          verticalSpace(24),
          SizedBox(
            width: double.infinity,
            height: 54.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              onPressed: () {
                EasyLocalization.of(context)!.setLocale(_langs[_selected]!);
                SharedPrefServices.setValue(_selected, Constants.language);
                Navigator.pop(context);
              },
              child: Text(
                'save'.tr(),
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.primary.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.primary.withValues(alpha: 0.3)
                : ColorManager.primary.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: isSelected ? 'SSTArabicMedium' : 'SSTArabicRoman',
                fontSize: 16.sp,
                color: isSelected
                    ? ColorManager.primary
                    : (isDark ? Colors.white70 : ColorManager.textHigh),
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: ColorManager.primary,
                size: 22.sp,
              ),
          ],
        ),
      ),
    );
  }
}
