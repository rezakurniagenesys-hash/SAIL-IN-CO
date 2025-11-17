import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_date_picker.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class ReportSalesScreen extends StatelessWidget {
  const ReportSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: 'Report Settlement', onRefresh: () {}),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppInputField(
                    label: 'Search',
                    hintText: 'Search',
                    controller: TextEditingController(),
                    onChanged: (value) {
                      // handle search logic here
                    },
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () async {
                    final date = await showAppDatePicker(context);
                    if (date != null) {
                      print("Tanggal dipilih: $date");
                    }
                  },
                  child: SvgPicture.asset(AssetIcons.icRoundDateRange, height: 28, colorFilter: const ColorFilter.mode(AppColors.sky950, BlendMode.srcIn)),
                ),
              ],
            ),
            Divider(color: AppColors.border, height: 32),
            Expanded(
              child: ListView.separated(
                itemCount: 20,
                separatorBuilder: (context, index) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  return itemReportSales();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemReportSales() {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('S.12112025.001', style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.textPrimary)),
                Text('06-11-2025', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
              ],
            ),
            const Spacer(),
            Text('Rp 10,000.000', style: AppTextStyles.body2Medium.copyWith(color: AppColors.sky700)),
          ],
        ),
        const SizedBox(height: 8),
        Divider(color: AppColors.border),
      ],
    );
  }
}
