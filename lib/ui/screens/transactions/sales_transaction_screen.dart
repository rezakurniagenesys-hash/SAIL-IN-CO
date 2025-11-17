import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/screens/order/components/widget/add_inventory.dart';
import 'package:sail_in_co/ui/screens/order/components/widget/item_inventory_quick_sales.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';

class SalesTransactionScreen extends StatelessWidget {
  const SalesTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: l.transaction_salesTransaction, onRefresh: () {}),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoItem(l.transaction_date, '06-11-2025'),
                        infoItem(l.transaction_warehouse, 'W.123123.12312'),
                        inputItem(l.transaction_address, 'Type something...'),
                        inputItem(l.transaction_idNumber, 'Type something...'),
                        infoItem(l.transaction_paymentType, 'Cash'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoItem(l.transaction_salesId, 'S.0213.123123 - Nathanael'),
                        inputItem(l.transaction_customerName, 'Type something...'),
                        inputItem(l.transaction_area, 'Type something...'),
                        inputItem(l.transaction_phoneNumber, 'Type something...'),
                        inputItem(l.transaction_remarks, 'Type something...'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l.transaction_inventoryDetail, style: AppTextStyles.body2Medium.copyWith(color: AppColors.textPrimary)),
                  AppButton(
                    label: l.transaction_addProduct,
                    icon: Icons.add,
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: l.transaction_addProduct,
                        content: AddInventory(),
                        actionButton: AppButton(
                          isFullWidth: true,
                          label: l.transaction_insert,
                          height: 42,
                          type: AppButtonType.primary,
                          onPressed: () => Navigator.pop(context),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...List.generate(4, (index) => Padding(padding: const EdgeInsets.only(bottom: 12), child: ItemInventoryQuickSales(isDescriptionVisible: true))),
              const SizedBox(height: 12 * 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [AppButton(label: l.transaction_payment, onPressed: () {})],
              ),
              const SizedBox(height: 12 * 5),
            ],
          ),
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
