import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/screens/customer/components/item_customer.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: l!.customer_title, onRefresh: () {}, showBack: false),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(l.customer_list, style: AppTextStyles.body2Medium.copyWith(fontSize: 16)),
            Divider(color: AppColors.border),
            Row(
              children: [
                Expanded(
                  child: AppInputField(
                    hintText: l.customer_search,
                    controller: TextEditingController(),
                    onChanged: (value) {
                      // Handle search logic here
                    },
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () async {
                    // final date = await showAppDatePicker(context);
                    // if (date != null) {
                    //   print("Tanggal dipilih: $date");
                    // }
                  },
                  child: SvgPicture.asset(AssetIcons.letsIconsUserScanFill, height: 36, colorFilter: const ColorFilter.mode(AppColors.sky950, BlendMode.srcIn)),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ItemCustomer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
