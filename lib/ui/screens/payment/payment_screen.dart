import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/screens/payment/enums/payments_enum.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dropdown_field.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.paymentType});
  final PaymentType paymentType;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    String labelLanguage;
    switch (paymentType) {
      case PaymentType.quickSalesPayment:
        labelLanguage = l.payment_quickSalesPayment;
        break;
      case PaymentType.salesOrderPayment:
        labelLanguage = l.payment_salesOrderPayment;
        break;
      case PaymentType.returnPayment:
        labelLanguage = l.payment_returnPayment;
        break;
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: labelLanguage, onRefresh: () {}),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Center(
              child: Column(
                spacing: 8,
                children: [
                  Text(l.payment_totalAmount, style: AppTextStyles.body2Medium.copyWith(color: AppColors.textPrimary)),
                  Text('Rp 38,000.00', style: AppTextStyles.heading3Bold.copyWith(color: AppColors.textPrimary)),
                  if (paymentType != PaymentType.returnPayment)
                    Text('${l.payment_remainingPayment} : Rp 28,000.00 ', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.textPrimary)),
                ],
              ),
            ),
            SizedBox(height: 12 * 2),
            if (paymentType != PaymentType.returnPayment) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Text(l.payment_returnId, style: AppTextStyles.body2Medium.copyWith(color: AppColors.textPrimary)),
                    SizedBox(width: 12),
                    Expanded(
                      child: AppDropdownField(
                        borderSideColor: AppColors.neutral400,
                        hintText: l.payment_returnId,
                        value: null,
                        items: ['RET.0123123.1231321', 'RET.37488482.23232113'],
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: AppColors.neutral200,
                child: Row(
                  children: [
                    Text(l.payment_returnValue, style: AppTextStyles.label3Medium.copyWith(color: AppColors.textPrimary)),
                    Text('- Rp 10,000.00', style: AppTextStyles.label3Medium.copyWith(color: AppColors.textPrimary)),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Divider(color: AppColors.neutral200, height: 2),
              ),
            ],

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.payment_paymentMethod, style: AppTextStyles.body2Medium.copyWith(color: AppColors.textPrimary)),
                  SizedBox(height: 8),
                  AppDropdownField(
                    borderSideColor: AppColors.neutral400,
                    hintText: l.payment_paymentMethod,
                    value: null,
                    items: ['BCA Virtual Account - 01312435121231', 'BNI Virtual Account - 9283742397489324'],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            if (paymentType != PaymentType.returnPayment)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Divider(color: AppColors.neutral200, height: 2),
              ),
            if (paymentType == PaymentType.returnPayment) SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(label: l.payment_pendingPayment, type: AppButtonType.warning, onPressed: () {}),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: AppButton(label: l.payment_confirmPayment, type: AppButtonType.primary, onPressed: () {}),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
