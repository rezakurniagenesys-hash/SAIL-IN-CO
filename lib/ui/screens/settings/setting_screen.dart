import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/services/locale_service.dart';
import 'package:sail_in_co/ui/screens/profile/profile_screen.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final localeService = Provider.of<LocaleService>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: l.setting_title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.person, color: AppColors.sky950),
                title: Text(l.setting_account, style: AppTextStyles.label2SemiBold),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                },
              ),
              Divider(color: AppColors.border),
              ListTile(
                leading: SvgPicture.asset(
                  AssetIcons.supportTeam,
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(AppColors.sky950, BlendMode.srcIn),
                ),
                subtitle: Text(AppLocalizations.of(context)!.languageSelect),
                title: Text(l.setting_language, style: AppTextStyles.label2SemiBold),
                onTap: () {
                  AppDialog.show(
                    context: context,
                    title: l.setting_language,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Bahasa Indonesia'),
                          trailing: localeService.locale.languageCode == 'id' ? const Icon(Icons.check, color: AppColors.sky950) : null,
                          onTap: () {
                            localeService.switchLanguage('id');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('English'),
                          trailing: localeService.locale.languageCode == 'en' ? const Icon(Icons.check, color: AppColors.sky950) : null,
                          onTap: () {
                            localeService.switchLanguage('en');
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              Divider(color: AppColors.border),
              ListTile(
                leading: SvgPicture.asset(
                  AssetIcons.clarityLanguageSolid,
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(AppColors.sky950, BlendMode.srcIn),
                ),
                title: Text(l.setting_helpSupport, style: AppTextStyles.label2SemiBold),
                onTap: () {
                  // Handle privacy tap
                },
              ),
              Divider(color: AppColors.border),
              ListTile(
                leading: const Icon(Icons.info, color: AppColors.sky950),
                title: Text(l.setting_about, style: AppTextStyles.label2SemiBold),
                onTap: () {
                  // Handle about tap
                },
              ),
              Divider(color: AppColors.border),
            ],
          ),
        ),
      ),
    );
  }
}
