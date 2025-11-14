import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: 'Return Payment', onRefresh: () {}),
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
                      Text('Not Visited', style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.textPrimary)),
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
                        infoItem('Customer ID', 'C0001'),
                        infoItem('Jenis Pembayaran', 'Credit'),
                        infoItem('Sales ID', 'Jl. Merpati No. 45, Jakarta'),
                        infoItem('Alamat', 'Jl. Jeruk Sidoarjo Gedangan'),
                        infoItem('KTP', '01231231312412'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoItem('Warehouse ID', 'W.123123.12312'),
                        infoItem('Kota', 'Surabaya'),
                        infoItem('Area', 'Ketintang'),
                        infoItem('Nomor HP', '085xxxxxxxx'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Detail Inventory', style: AppTextStyles.body2Medium.copyWith(color: AppColors.textPrimary)),
                  AppButton(
                    label: 'Add Product',
                    icon: Icons.add,
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Add Product',
                        content: AddInventory(),
                        actionButton: AppButton(
                          isFullWidth: true,
                          label: 'Insert',
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
              SummaryRow(data: const {'Disc': 'Rp 38,000.00', 'Subtotal': 'Rp 0.00', 'Grand Total': 'Rp 38,000.00'}),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    label: 'Payment',
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
