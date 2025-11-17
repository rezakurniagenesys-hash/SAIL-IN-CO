import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dropdown_field.dart';

class CustomerEditScreen extends StatelessWidget {
  const CustomerEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: l!.customerDetail_editCustomerData, onRefresh: () {}),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                spacing: 14,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  inputItem(l.customerDetail_customerName, 'Type something...'),
                  inputItem(l.customerDetail_labelAddress, 'Type something...'),
                  inputItem(l.customerDetail_labelArea, 'Type something...'),
                  inputItem(l.customerDetail_labelPhoneNumber, 'Type something...'),
                  AppDropdownField(
                    borderSideColor: AppColors.neutral400,
                    label: l.customerDetail_labelCustomerType,
                    value: null,
                    items: [l.customerDetail_customerTypeRetail, l.customerDetail_customerTypeWholesale],
                    onChanged: (value) {},
                  ),
                  AppDropdownField(
                    borderSideColor: AppColors.neutral400,
                    label: l.customerDetail_labelPaymentType,
                    value: null,
                    items: [l.customerDetail_paymentCash, l.customerDetail_paymentCredit],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AppButton(
                label: l.customerDetail_saveChanges,
                type: AppButtonType.sky950,
                height: 48,
                isFullWidth: true,
                onPressed: () {
                  // Handle save action
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Info statis
  Widget infoItem(String label, String value) {
    return SizedBox(
      height: 45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          Text(value, style: AppTextStyles.body3Regular.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  /// 🔹 Input field dengan label terpisah, tidak floating
  Widget inputItem(String label, String hintText) {
    return SizedBox(
      height: 45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label tetap di atas, tidak floating
          Text(label, style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          // TextField tetap proporsional
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.body3Regular,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                isDense: true,
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8),
                //   borderSide: BorderSide(color: AppColors.border),
                // ),
              ),
              style: AppTextStyles.body3Regular,
            ),
          ),
        ],
      ),
    );
  }
}
