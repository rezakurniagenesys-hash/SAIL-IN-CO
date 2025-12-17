// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/utils/debouncer.dart';
import 'package:sail_in_co/providers/sales/sales_provider.dart';
import 'package:sail_in_co/ui/screens/customer_detail/components/item_history_sales.dart';
import 'package:sail_in_co/ui/screens/customer_detail/sub_feature/view_outstanding_order_screen.dart';
import 'package:sail_in_co/ui/screens/customer_detail/sub_feature/view_quick_sales_order_screen.dart';
import 'package:sail_in_co/ui/screens/receipt/receipt_pdf_quick_sales_view.dart';
import 'package:sail_in_co/ui/screens/receipt/receipt_pdf_sales_order_view.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_date_picker.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';
import 'package:sail_in_co/ui/widgets/app_dropdown_field.dart';
import 'package:sail_in_co/ui/widgets/app_infinite_list.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key, required this.customerId});

  final String customerId;
  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provider = context.read<SalesProvider>();
      provider.clearData();
      provider.getHistorySales(initial: true, customerId: widget.customerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SalesProvider>();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppInputField(
                controller: provider.historySearchController,
                onChanged: (value) {
                  _debouncer.run(() {
                    provider.searchHistorySalesOrders(value, widget.customerId);
                  });
                },
              ),
            ),
            SizedBox(width: 8),
            InkWell(
              onTap: () async {
                AppDialog.show(
                  context: context,
                  title: 'Filter Date',
                  content: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppInputField(
                              controller: provider.historyStartDateController,
                              hintText: 'Start Date',
                              // readOnly: true,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  AssetIcons.icRoundDateRange,
                                  height: 16,
                                  colorFilter: const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
                                ),
                              ),
                              onTap: () async {
                                final date = await showAppDatePicker(context);
                                if (date != null) {
                                  provider.setHistoryStartDate(date);
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: AppInputField(
                              hintText: 'End Date',
                              controller: provider.historyEndDateController,
                              // readOnly: true,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  AssetIcons.icRoundDateRange,
                                  height: 16,
                                  colorFilter: const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
                                ),
                              ),
                              onTap: () async {
                                final date = await showAppDatePicker(context);
                                if (date != null) {
                                  provider.setHistoryEndDate(date);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actionButton: AppButton(
                    label: 'Filter',
                    isFullWidth: true,
                    type: AppButtonType.primary,
                    height: 42,
                    onPressed: () {
                      provider.filterHistoryDate(widget.customerId);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              child: SvgPicture.asset(AssetIcons.icRoundDateRange, height: 28, colorFilter: const ColorFilter.mode(AppColors.sky950, BlendMode.srcIn)),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildList(),
      ],
    );
  }

  Widget _buildList() {
    return Consumer<SalesProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async => provider.getHistorySales(initial: true, customerId: widget.customerId),
          child: AppInfinityList(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            items: provider.dataHistorySalesOrder,
            isLoading: provider.isLoadingHistory,
            isLoadMore: provider.isLoadMoreHistory,
            onLoadMore: () => provider.getHistorySales(loadMore: true, customerId: widget.customerId),
            itemBuilder: (context, index) {
              final transactionType = provider.dataHistorySalesOrder[index].transactionType;
              return ItemHistorySales(
                item: provider.dataHistorySalesOrder[index],
                onView: () {
                  if (transactionType == "quick_sales") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewQuickSalesOrderScreen(salesOrderId: provider.dataHistorySalesOrder[index].transactionId)),
                    );
                  } else if (transactionType == "sales_order") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ViewOutstandingOrderScreen(salesOrderId: provider.dataHistorySalesOrder[index].transactionId, isShippingOrder: false),
                      ),
                    );
                  }
                },
                onPrint: () {
                  AppDialog.show(
                    context: context,
                    title: 'Print Invoice',
                    content: Column(
                      children: [
                        Text('Print', style: AppTextStyles.label2SemiBold),
                        Container(margin: const EdgeInsets.symmetric(vertical: 12), height: 1, color: AppColors.sky600),
                        SvgPicture.asset(AssetIcons.printIcon, width: 50, height: 50),
                        Row(
                          children: [
                            Text('Device', style: AppTextStyles.body4Medium.copyWith(color: AppColors.textPrimary)),
                            Spacer(),
                            Text('Status', style: AppTextStyles.body4Medium.copyWith(color: AppColors.emerald600)),
                          ],
                        ),
                        SizedBox(height: 12),
                        AppDropdownField(label: 'Printer Name', value: '', items: [], onChanged: (value) {}),
                        SizedBox(height: 16),
                        AppButton(isDisabled: true, height: 44, label: 'Refresh', onPressed: () {}, isFullWidth: true, type: AppButtonType.primary),
                        SizedBox(height: 16),
                        AppButton(height: 44, label: 'Print', onPressed: () {}, isFullWidth: true, type: AppButtonType.primary),
                        SizedBox(height: 16),
                        AppButton(
                          height: 44,
                          label: 'Download as PDF',
                          onPressed: () {
                            if (transactionType == "quick_sales") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => ReceiptPdfQuickSalesView(quicSalesId: provider.dataHistorySalesOrder[index].transactionId)),
                              );
                            } else if (transactionType == "sales_order") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => ReceiptPdfSalesOrderView(salesOrderId: provider.dataHistorySalesOrder[index].transactionId)),
                              );
                            }
                          },
                          isFullWidth: true,
                          type: AppButtonType.primary,
                        ),
                      ],
                    ),
                  );
                },
                onDelete: () {
                  AppDialog.show(
                    context: context,
                    title: 'Batalkan Order',
                    content: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text('Apakah anda yakin ingin membatalkan order ini?', textAlign: TextAlign.center, style: AppTextStyles.body3Regular),
                    ),
                    actionButton: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            isFullWidth: true,
                            label: 'Tidak',
                            height: 42,
                            type: AppButtonType.neutral400,
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: AppButton(
                            isFullWidth: true,
                            label: 'Batalkan',
                            height: 42,
                            isLoading: provider.isLoadingSalesOrderVoid,
                            type: AppButtonType.danger,
                            onPressed: () async {
                              Navigator.pop(context);
                              if (transactionType == "quick_sales") {
                                await provider.voidQuickSales(
                                  context: context,
                                  quickSalesId: provider.dataHistorySalesOrder[index].transactionId,
                                  customerId: widget.customerId,
                                );
                                provider.getHistorySales(initial: true, customerId: widget.customerId);
                              } else if (transactionType == "sales_order") {
                                await provider.voidSalesOrder(
                                  context: context,
                                  salesOrderId: provider.dataHistorySalesOrder[index].transactionId,
                                  customerId: widget.customerId,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
