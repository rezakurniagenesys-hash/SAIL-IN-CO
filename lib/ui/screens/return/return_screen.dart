import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/utils/currency_format.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/data/models/general/order/general_order_draft_item.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/order/general_order_provider.dart';
import 'package:sail_in_co/providers/return/return_provider.dart';
import 'package:sail_in_co/ui/screens/order/components/widget/add_edit_inventory.dart';
import 'package:sail_in_co/ui/screens/order/components/widget/item_inventory_quick_sales.dart';
import 'package:sail_in_co/ui/screens/order/components/widget/sumary_row.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';
import 'package:sail_in_co/ui/widgets/app_snackbar.dart';

class ReturnScreen extends StatefulWidget {
  const ReturnScreen({super.key, this.customerDetailData});
  final CustomerDetailData? customerDetailData;
  @override
  State<ReturnScreen> createState() => _ReturnScreenState();
}

class _ReturnScreenState extends State<ReturnScreen> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<ReturnProvider>();
    provider.loadUserInfo();
    provider.setCustomerDetailData(widget.customerDetailData);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: l.customerDetail_returnPayment, onRefresh: () {}),
      body: Consumer2<ReturnProvider, GeneralOrderProvider>(
        builder: (context, returnProvider, generalOrderProvider, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                            infoItem(l.order_date, DateTime.now().toString().split(' ').first),
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
                            infoItem(l.order_salesOrder, returnProvider.userInfo?.userId ?? ''),
                            infoItem(l.order_area, widget.customerDetailData?.customer?.areaName ?? '-'),
                            inputItem(l.order_remark, '', returnProvider.notesController, (value) {
                              returnProvider.setNotes(value);
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
                        icon: Icons.add,
                        onPressed: () async {
                          // reset form
                          generalOrderProvider.clearSelection();
                          // set old inventory ids
                          generalOrderProvider.setOldInventoryIds(returnProvider.returnOrderItems.map((e) => e.inventory.inventoryId).toList());
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
                            returnProvider.addReturnOrderItem(result);
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
                    itemCount: returnProvider.returnOrderItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ItemInventoryQuickSales(
                          item: returnProvider.returnOrderItems[index],
                          isDescriptionVisible: returnProvider.returnOrderItems[index].notes.isNotEmpty,
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
                                returnProvider.updateReturnOrderItem(index, result);
                                AppSnackBar.show(context, message: "Produk berhasil diperbarui!", color: Colors.green);
                              }
                            });
                          },
                          onDelete: () {
                            returnProvider.removeReturnOrderItem(index);
                            AppSnackBar.show(context, message: "Produk berhasil dihapus!", color: Colors.green);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12 * 3),
                  SummaryRow(
                    data: {
                      l.order_subtotal: CurrencyFormat.toRupiah(returnProvider.subTotal()),
                      l.order_discount: CurrencyFormat.toRupiah(returnProvider.totalDiscount()),
                      l.order_grandTotalPayment: CurrencyFormat.toRupiah(returnProvider.grandTotal()),
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppButton(
                        label: l.order_save,
                        isLoading: returnProvider.isLoadingSubmit,
                        onPressed: () {
                          returnProvider.submit(context);
                        },
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
