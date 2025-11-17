import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class SyncDataDialogContent extends StatelessWidget {
  const SyncDataDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Column(
      spacing: 12,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: AppColors.sky700, borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.sync, color: AppColors.white),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(l!.homeDialog_syncSubtitle, textAlign: TextAlign.center, style: AppTextStyles.body3Regular),
        ),
        AppInputField(
          label: l.homeDialog_inputKmStart,
          hintText: l.homeDialog_inputDescription,
          suffixIcon: Padding(padding: const EdgeInsets.all(12.0), child: SvgPicture.asset(AssetIcons.kmIcon, height: 10)),
        ),
        Text(l.homeDialog_warningInternet, style: AppTextStyles.body3Regular.copyWith(color: AppColors.error)),
      ],
    );
  }
}
