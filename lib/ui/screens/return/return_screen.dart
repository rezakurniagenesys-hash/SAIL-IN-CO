import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/screens/order/components/widget/add_inventory.dart';
import 'package:sail_in_co/ui/screens/order/components/widget/item_inventory_quick_sales.dart';
import 'package:sail_in_co/ui/screens/order/components/widget/sumary_row.dart';
import 'package:sail_in_co/ui/screens/payment/enums/payments_enum.dart';
import 'package:sail_in_co/ui/screens/payment/payment_screen.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';

class ReturnScreen extends StatelessWidget {
  const ReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: l.customerDetail_returnPayment, onRefresh: () {}),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Toko Bu Siti',
                    style: AppTextStyles.heading4Medium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 4),
                      Text(l.home_notVisited, style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.textPrimary)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoItem(l.order_customerId, 'C0001'),
                        infoItem(l.order_paymentType, 'Credit'),
                        infoItem(l.order_salesId, 'Jl. Merpati No. 45, Jakarta'),
                        infoItem(l.order_address, 'Jl. Jeruk Sidoarjo Gedangan'),
                        infoItem(l.order_ktp, '01231231312412'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoItem(l.order_warehouseId, 'W.123123.12312'),
                        infoItem(l.order_city, 'Surabaya'),
                        infoItem(l.order_area, 'Ketintang'),
                        infoItem(l.order_phoneNumber, '085xxxxxxxx'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l.order_inventoryDetail, style: AppTextStyles.body2Medium.copyWith(color: AppColors.textPrimary)),
                  AppButton(
                    label: l.order_addProduct,
                    icon: Icons.add,
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: l.order_addProduct,
                        content: AddInventory(),
                        actionButton: AppButton(
                          isFullWidth: true,
                          label: l.order_insert,
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
              SummaryRow(data: {l.order_discount: 'Rp 38,000.00', l.order_subtotal: 'Rp 0.00', l.order_grandTotalPayment: 'Rp 38,000.00'}),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    label: l.order_payment,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(paymentType: PaymentType.returnPayment)));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12 * 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.textPrimary)),
        Text(value, style: AppTextStyles.body3Regular.copyWith(color: AppColors.textPrimary)),
      ],
    );
  }
}
