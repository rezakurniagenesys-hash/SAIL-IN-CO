import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/utils/currency_format.dart';
import 'package:sail_in_co/data/models/payment/payment_method_response.dart';
import 'package:sail_in_co/data/models/quicksales/quick_sales_payload_model.dart';
import 'package:sail_in_co/data/models/sales/sales_return_response.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/payment/payment_provider.dart';
import 'package:sail_in_co/ui/screens/payment/enums/payments_enum.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dropdown_search.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.paymentType, this.quickSalesPayloadModel});
  final PaymentType paymentType;
  final QuickSalesPayloadModel? quickSalesPayloadModel;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<PaymentProvider>();
      provider.init(context, widget.quickSalesPayloadModel?.customerId ?? "");
      if (widget.quickSalesPayloadModel != null) {
        // provider.init(context, widget.quickSalesPayloadModel?.customerId ?? "");
        provider.setQuickSalesPayloadModel(widget.quickSalesPayloadModel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    String labelLanguage;
    switch (widget.paymentType) {
      case PaymentType.quickSalesPayment:
        labelLanguage = l.payment_quickSalesPayment;
        break;
      case PaymentType.salesOrderPayment:
        labelLanguage = l.payment_salesOrderPayment;
        break;
      case PaymentType.returnPayment:
        labelLanguage = l.payment_returnPayment;
        break;
      case PaymentType.outstandingOrderPayment:
        labelLanguage = l.payment_outstandingOrderPayment;
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: labelLanguage, onRefresh: () {}),
      body: Consumer<PaymentProvider>(
        builder: (context, paymentProvider, child) {
          if (paymentProvider.isLoading) {
            return Center(
              child: Padding(padding: const EdgeInsets.all(50), child: CircularProgressIndicator()),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Center(
                  child: Column(
                    spacing: 8,
                    children: [
                      Text(l.payment_totalAmount, style: AppTextStyles.body2Medium.copyWith(color: AppColors.textPrimary)),
                      Text(
                        CurrencyFormat.toRupiah(paymentProvider.quickSalesPayloadModel?.grandTotal),
                        style: AppTextStyles.heading3Bold.copyWith(color: AppColors.textPrimary),
                      ),
                      if (widget.paymentType != PaymentType.returnPayment)
                        Text(
                          '${l.payment_remainingPayment} : ${CurrencyFormat.toRupiah(paymentProvider.remainingPayment)}',
                          style: AppTextStyles.body4Reguler.copyWith(color: AppColors.textPrimary),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 12 * 2),
                if (widget.paymentType != PaymentType.returnPayment) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(l.payment_returnId, style: AppTextStyles.body2Medium.copyWith(color: AppColors.textPrimary)),
                        SizedBox(width: 12),
                        Expanded(
                          child: AppDropdownSearch<SalesReturnData>(
                            label: l.payment_returnId,
                            hintText: l.payment_returnId,
                            value: null,
                            items: paymentProvider.salesReturnData,
                            onChanged: (value) {
                              paymentProvider.setSelectedSalesReturn(value);
                            },
                            display: (SalesReturnData item) => item.salesReturnId,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a return ID';
                              }
                              return null;
                            },
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l.payment_returnValue, style: AppTextStyles.label3Medium.copyWith(color: AppColors.textPrimary)),
                        Text(
                          ' - ${CurrencyFormat.toRupiah(paymentProvider.selectedSalesReturn?.sisa)}',
                          style: AppTextStyles.label3Medium.copyWith(color: AppColors.textPrimary),
                        ),
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
                      AppDropdownSearch<PaymentMethodData>(
                        borderSideColor: AppColors.neutral400,
                        label: l.payment_paymentMethod,
                        hintText: l.payment_paymentMethod,
                        value: null,
                        items: paymentProvider.paymentMethodData,
                        onChanged: (value) {
                          paymentProvider.setSelectedPaymentMethod(value);
                        },
                        display: (PaymentMethodData item) => "${item.slipName} - ${item.salesAccCode}",
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a payment method';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                if (widget.paymentType != PaymentType.returnPayment)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Divider(color: AppColors.neutral200, height: 2),
                  ),
                if (widget.paymentType == PaymentType.returnPayment) SizedBox(height: 18),

                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      if (widget.paymentType == PaymentType.returnPayment)
                        Expanded(
                          child: AppButton(label: l.payment_pendingPayment, type: AppButtonType.warning, onPressed: () {}),
                        ),
                      SizedBox(width: 12),
                      Expanded(
                        child: AppButton(
                          isLoading: paymentProvider.isLoadingSubmit,
                          height: 44,
                          label: l.payment_confirmPayment,
                          type: AppButtonType.primary,
                          onPressed: () {
                            paymentProvider.confirmPayment(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
