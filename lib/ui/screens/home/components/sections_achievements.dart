import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/screens/home/widgets/circle_achivement.dart';
import 'package:sail_in_co/ui/screens/report/report_sales_screen.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';

class SectionsAchievementsDashboard extends StatelessWidget {
  const SectionsAchievementsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.secondaryGradient,
          border: Border.all(color: AppColors.sky200, width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 3))],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            spacing: 16,
            children: [
              Text(l?.home_achievements ?? '', style: AppTextStyles.heading3Medium.copyWith(color: AppColors.white)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAchivement(title: l?.home_registeredCustomers ?? '', count: 10),
                  CircleAchivement(title: l?.home_newCustomers ?? '', count: 4),
                  CircleAchivement(title: l?.home_soldStock ?? '', count: 7),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: AppButton(
                  isFullWidth: true,
                  type: AppButtonType.sky50,
                  height: 38,
                  label: l?.home_settlement ?? '',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReportSalesScreen()));
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
