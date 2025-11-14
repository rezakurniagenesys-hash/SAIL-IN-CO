import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/ui/screens/history_uangkas/components/item_history_uangkas.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_date_picker.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class HistoryUangkasScreen extends StatelessWidget {
  const HistoryUangkasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: 'History Uang Kas', onRefresh: () {}),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 12,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppInputField(
                    hintText: 'Search',
                    controller: TextEditingController(),
                    onChanged: (value) {
                      // Handle search logic here
                    },
                  ),
                ),
                SizedBox(width: 8),
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
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ItemHistoryUangkas();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
