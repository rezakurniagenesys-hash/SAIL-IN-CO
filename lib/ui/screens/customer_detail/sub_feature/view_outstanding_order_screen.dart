// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/constants/asset_images.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/utils/currency_format.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/sales/sales_provider.dart';
import 'package:sail_in_co/ui/screens/order/components/widget/sumary_row.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';

class ViewOutstandingOrderScreen extends StatefulWidget {
  const ViewOutstandingOrderScreen({super.key, this.salesOrderId, this.isShippingOrder = false});
  final String? salesOrderId;
  final bool isShippingOrder;

  @override
  State<ViewOutstandingOrderScreen> createState() => _ViewOutstandingOrderScreenState();
}

class _ViewOutstandingOrderScreenState extends State<ViewOutstandingOrderScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = context.read<SalesProvider>();
      provider.getDetailOutstandingSalesOrders(salesOrderId: widget.salesOrderId ?? '', context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(
        title: widget.isShippingOrder ? l?.customerDetail_shippingOrderDetail ?? '' : l?.customerDetail_outstandingOrderDetail ?? '',
        onRefresh: () {},
      ),
      body: Consumer<SalesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingDetail) {
            return Center(child: CircularProgressIndicator(color: AppColors.sky700));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.salesOrderHeader?.customerNmAcc6 ?? '-',
                        style: AppTextStyles.heading4Medium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
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
                            infoItem(l!.order_date, DateUtilsHelper.formatDMY(DateTime.parse(provider.salesOrderHeader?.salesOrderDate ?? ''))),
                            if (widget.isShippingOrder == false) infoItem(l.customerDetail_salesOrderId, provider.salesOrderHeader?.salesOrderId ?? ''),
                            infoItem(l.order_codeCustomer, provider.salesOrderHeader?.customerId ?? '-'),
                            infoItem(l.order_address, provider.salesOrderHeader?.customerAddress ?? ''),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            infoItem(l.order_codeSales, provider.salesOrderHeader?.salesId ?? ''),
                            if (widget.isShippingOrder == false) infoItem(l.customerDetail_shippingID, provider.salesOrderHeader?.shippingId ?? '-'),
                            infoItem(l.order_area, provider.salesOrderHeader?.areaAreaName ?? ''),
                            infoItem(l.order_remark, provider.salesOrderHeader?.notes ?? '-'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(l.order_inventoryDetail, style: AppTextStyles.body2Medium.copyWith(color: AppColors.textPrimary)),
                  const SizedBox(height: 24),
                  if (provider.salesOrderHeader?.details != null && provider.salesOrderHeader!.details.isNotEmpty)
                    Column(
                      spacing: 12,
                      children:
                          provider.salesOrderHeader?.details.map((item) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.neutral200),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(item.inventory?.inventoryName ?? '', style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary)),
                                        Text(
                                          '${item.qty2} ${item.uom2?.uomId ?? ''}',
                                          style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          l.order_subTotalProduct,
                                          style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          CurrencyFormat.toRupiah(item.subTotal),
                                          style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    if (int.parse(item.discValue ?? '0') > 0)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            l.order_discount,
                                            style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                            CurrencyFormat.toRupiah((int.parse(item.discValue ?? '0') * int.parse(item.qty2))),
                                            style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }).toList() ??
                          [],
                    ),
                  const SizedBox(height: 12 * 3),
                  SummaryRow(
                    data: {
                      l.order_subtotal: CurrencyFormat.toRupiah(provider.subTotal()),
                      l.order_discount: CurrencyFormat.toRupiah(provider.totalDiscount()),
                      l.order_grandTotalPayment: CurrencyFormat.toRupiah(provider.grandTotal()),
                    },
                  ),
                  const SizedBox(height: 24),
                  if (widget.isShippingOrder)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          label: l.customerDetail_shipping,
                          onPressed: () async {
                            // await provider.postShippingForSalesOrder(context: context, salesOrderId: widget.salesOrderId ?? '');
                            AppDialog.show(
                              context: context,
                              title: l.customerDetail_shipping,
                              content: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(AssetImages.shipping, height: 50, width: 50, fit: BoxFit.contain),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Center(
                                    child: Text(
                                      'pastikan semua item yang akan dikirim sudah sesuai dengan pesanan  customer',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.body3Regular.copyWith(color: AppColors.textPrimary),
                                    ),
                                  ),
                                ],
                              ),
                              actionButton: Row(
                                children: [
                                  Expanded(
                                    child: AppButton(
                                      label: 'Batal',
                                      type: AppButtonType.neutral400,
                                      isFullWidth: true,
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      isLoading: provider.isSubmitting,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: AppButton(
                                      label: 'Proses',
                                      type: AppButtonType.primary,
                                      isFullWidth: true,
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await provider.postShippingForSalesOrder(context: context, salesOrderId: widget.salesOrderId ?? '');
                                      },
                                      isLoading: provider.isSubmitting,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          isLoading: provider.isSubmitting,
                        ),
                      ],
                    ),
                  const SizedBox(height: 12 * 5),
                ],
              ),
            ),
          );
        },
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
