// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/utils/currency_format.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/data/models/general/order/general_order_draft_item.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/generals/general_providers.dart';
import 'package:sail_in_co/providers/order/general_order_provider.dart';
import 'package:sail_in_co/providers/order/quick_sales_provider.dart';
import 'package:sail_in_co/ui/screens/order/components/widget/add_edit_inventory.dart';
import 'package:sail_in_co/ui/screens/order/components/widget/item_inventory_quick_sales.dart';
import 'package:sail_in_co/ui/screens/order/components/widget/sumary_row.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';
import 'package:sail_in_co/ui/widgets/app_snackbar.dart';

class QuickSales extends StatefulWidget {
  const QuickSales({super.key, this.customerDetailData});

  final CustomerDetailData? customerDetailData;

  @override
  State<QuickSales> createState() => _QuickSalesState();
}

class _QuickSalesState extends State<QuickSales> {
  @override
  void initState() {
    final provider = context.read<QuickSalesProvider>();
    provider.setCustomerDetailData(widget.customerDetailData);

    final generalOrderProvider = context.read<GeneralOrderProvider>();
    generalOrderProvider.setPriceMode(OrderPriceMode.lockedFromMaster);
    generalOrderProvider.setType(OrderType.quickSales);
    // generalOrderProvider.setIsPriceEditable(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Consumer2<QuickSalesProvider, GeneralOrderProvider>(
      builder: (context, quickSalesProvider, generalOrderProvider, _) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              Text(
                widget.customerDetailData?.customer?.name ?? '-',
                style: AppTextStyles.heading4Medium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
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
                        infoItem(l!.order_date, DateUtilsHelper.formatDMY(DateTime.now())),
                        infoItem(l.order_codeCustomer, widget.customerDetailData?.customer?.noAcc6 ?? '-'),
                        infoItem(l.order_address, widget.customerDetailData?.customer?.address ?? '-'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoItem(l.order_salesOrder, quickSalesProvider.userInfo?.userId ?? ''),
                        infoItem(l.order_area, widget.customerDetailData?.customer?.areaName ?? '-'),
                        inputItem(l.order_remark, '', quickSalesProvider.notesController, (value) {
                          quickSalesProvider.setNotes(value);
                        }),
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
                    isLoading: context.watch<GeneralProviders>().isLoadingInventory,
                    icon: Icons.add,
                    onPressed: () async {
                      // reset form
                      await context.read<GeneralProviders>().getInventory(context);
                      generalOrderProvider.clearSelection();
                      // set old inventory ids
                      generalOrderProvider.setOldInventoryIds(quickSalesProvider.quickSalesItems.map((e) => e.inventory.inventoryId).toList());
                      final result = await AppDialog.show<GeneralOrderDraftItem>(
                        context: context,
                        title: l.order_addProduct,
                        content: AddEditInventory(),
                        actionButton: AppButton(
                          isFullWidth: true,
                          label: l.order_insert,
                          height: 42,
                          type: AppButtonType.primary,
                          onPressed: () {
                            generalOrderProvider.submit(context);
                          },
                        ),
                      );

                      if (result != null) {
                        quickSalesProvider.addQuickSalesItem(result);
                        AppSnackBar.show(context, message: "Produk berhasil ditambahkan!", color: Colors.green);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quickSalesProvider.quickSalesItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ItemInventoryQuickSales(
                      item: quickSalesProvider.quickSalesItems[index],
                      isDescriptionVisible: quickSalesProvider.quickSalesItems[index].notes.isNotEmpty,
                      onEdit: (editedItem) {
                        generalOrderProvider.clearSelection();
                        generalOrderProvider.initEdit(editedItem);
                        AppDialog.show<GeneralOrderDraftItem>(
                          context: context,
                          title: l.order_editProduct,
                          content: AddEditInventory(),
                          actionButton: AppButton(
                            isFullWidth: true,
                            label: l.order_edit,
                            height: 42,
                            type: AppButtonType.primary,
                            onPressed: () {
                              generalOrderProvider.submit(context);
                            },
                          ),
                        ).then((result) {
                          if (result != null) {
                            quickSalesProvider.updateQuickSalesItem(index, result);
                            AppSnackBar.show(context, message: "Produk berhasil diperbarui!", color: Colors.green);
                          }
                        });
                      },
                      onDelete: () {
                        quickSalesProvider.removeQuickSalesItem(index);
                        AppSnackBar.show(context, message: "Produk berhasil dihapus!", color: Colors.green);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 12 * 3),
              SummaryRow(
                data: {
                  l.order_subtotal: CurrencyFormat.toRupiah(quickSalesProvider.subTotal()),
                  l.order_discount: CurrencyFormat.toRupiah(quickSalesProvider.totalDiscount()),
                  l.order_grandTotalPayment: CurrencyFormat.toRupiah(quickSalesProvider.grandTotal()),
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    label: l.order_payment,
                    onPressed: () {
                      quickSalesProvider.submitPayment(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12 * 5),
            ],
          ),
        );
      },
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

  Widget inputItem(String label, String hintText, TextEditingController? controller, Function(String)? onChanged) {
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
              controller: controller,
              onChanged: onChanged,
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
