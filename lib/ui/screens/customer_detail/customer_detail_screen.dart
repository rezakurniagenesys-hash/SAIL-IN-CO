// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/utils/currency_format.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/customer/customer_detail_provider.dart';
import 'package:sail_in_co/providers/generals/general_providers.dart';
import 'package:sail_in_co/providers/order/general_order_provider.dart';
import 'package:sail_in_co/providers/order/quick_sales_provider.dart';
import 'package:sail_in_co/providers/order/sales_order_provider.dart';
import 'package:sail_in_co/providers/return/return_provider.dart';
import 'package:sail_in_co/ui/screens/adjustment/adjustment_screen.dart';
import 'package:sail_in_co/ui/screens/customer_detail/customer_edit/customer_edit_screen.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/customer_bukti_foto.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/customer_upload_foto.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/draggable_scrollable_sheet_detail_customer.dart';
import 'package:sail_in_co/ui/screens/order/order_screen.dart';
import 'package:sail_in_co/ui/screens/return/return_screen.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomerDetailScreen extends StatefulWidget {
  const CustomerDetailScreen({super.key, required this.customerId, required this.scheduleId, this.hasVisited = ''});
  final String customerId;
  final String scheduleId;
  final String hasVisited;

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<CustomerDetailProvider>();
      provider.clear();
      provider.loadUserInfo();
      provider.getDetailCustomer(widget.customerId, widget.scheduleId, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final bool hasVisit = widget.hasVisited == '0' ? true : false;
    return Scaffold(
      backgroundColor: AppColors.sky700,
      appBar: AppBarCustom(
        title: l.customerDetail_title,
        onRefresh: () {
          final provider = context.read<CustomerDetailProvider>();
          provider.clear();
          provider.getDetailCustomer(widget.customerId, widget.scheduleId, context);
        },
      ),
      body: Consumer<CustomerDetailProvider>(
        builder: (context, provider, child) {
          final isLoading = provider.isLoading;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 160),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isLoading
                        ? shimmerHeader()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                provider.customerDetailData?.customer?.name ?? '-',
                                style: AppTextStyles.heading4Medium.copyWith(color: AppColors.white, fontWeight: FontWeight.w700),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: (provider.customerDetailData?.customer?.statusVisit == 2) ? AppColors.success : AppColors.error,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    //     customer?.statusVisit == 1
                                    // ? l!.customer_failedNotVisit
                                    // : customer?.statusVisit == 2
                                    // ? l!.customer_visit
                                    // : l!.customer_notVisit,
                                    provider.customerDetailData?.customer?.statusVisit == 1
                                        ? l.customer_failedNotVisit
                                        : provider.customerDetailData?.customer?.statusVisit == 2
                                        ? l.customer_visit
                                        : l.customer_notVisit,
                                    style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),

                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: isLoading
                              ? shimmerColumn()
                              : Column(
                                  spacing: 12,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    infoItem(l.customerDetail_customerCode, provider.customerDetailData?.customer?.noAcc6 ?? '-'),
                                    infoItem(
                                      l.customerDetail_paymentType,
                                      (provider.customerDetailData?.customer?.defaultPayment == null)
                                          ? '-'
                                          : provider.customerDetailData?.customer?.defaultPayment.toString() ?? '-',
                                    ),
                                    infoItem(l.customerDetail_salesCode, provider.userInfo?.userId ?? '-'),
                                    infoItem(l.customerDetail_address, provider.customerDetailData?.customer?.address ?? '-'),
                                    infoItem(l.customerDetail_ktp, provider.customerDetailData?.customer?.nik ?? '-'),
                                    infoItem(l.customerDetail_creditLimit, CurrencyFormat.toRupiah(provider.customerDetailData?.customer?.creditLimit ?? 0)),
                                  ],
                                ),
                        ),
                        Expanded(
                          child: isLoading
                              ? shimmerColumn()
                              : Column(
                                  spacing: 12,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    infoItem(l.customerDetail_warehouseCode, provider.userInfo?.userId ?? '-'),
                                    infoItem(l.customerDetail_customerType, provider.customerDetailData?.customer?.typeCustomer ?? '-'),
                                    infoItem(l.customerDetail_area, provider.customerDetailData?.customer?.areaName ?? '-'),
                                    infoItem(l.customerDetail_city, provider.customerDetailData?.customer?.city ?? '-'),
                                    infoItem(l.customerDetail_phoneNumber, provider.customerDetailData?.customer?.phone ?? '-'),
                                  ],
                                ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    if (provider.isLoading == false)
                      Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: AppButton(
                              label: l.customerDetail_editData,
                              type: AppButtonType.sky50,
                              height: 42,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerEditScreen()));
                              },
                            ),
                          ),
                          Expanded(
                            child: AppButton(
                              isDisabled: (provider.isUploadingImage || hasVisit),
                              disabledBackgroundColor: Colors.grey.shade300,
                              disabledTextColor: Colors.grey.shade600,
                              label: provider.customerDetailData?.customer?.linkPath != null ? l.customerDetail_photoEvidence : l.customerDetail_uploadPhoto,
                              type: AppButtonType.sky50,
                              isLoading: provider.isUploadingImage,

                              height: 42,
                              onPressed: () async {
                                if (provider.customerDetailData?.customer?.linkPath != null) {
                                  // sudah ada foto, tampilkan preview
                                  AppDialog.show(
                                    context: context,
                                    title: 'Foto Bukti',
                                    paddingContent: 0,
                                    content: CustomerBuktiFoto(data: provider.customerDetailData),
                                  );
                                  return;
                                }

                                provider.setLoadingImage(true);

                                try {
                                  // Step 1: pick image
                                  final picked = await provider.pickImage(context);

                                  if (!picked) {
                                    return; // nothing selected
                                  }

                                  CustomerUploadFotoAction? action;

                                  // Step 2: show preview dialog
                                  action = await AppDialog.show<CustomerUploadFotoAction>(
                                    context: context,
                                    title: 'Upload Foto',
                                    paddingContent: 0,
                                    content: CustomerUploadFoto(image: provider.image, customerId: widget.customerId, scheduleId: widget.scheduleId),
                                  );

                                  // Step 3: repick loop
                                  while (action == CustomerUploadFotoAction.repick) {
                                    final repicked = await provider.pickImage(context);
                                    if (!repicked) break;

                                    action = await AppDialog.show<CustomerUploadFotoAction>(
                                      context: context,
                                      title: 'Upload Foto',
                                      paddingContent: 0,
                                      content: CustomerUploadFoto(image: provider.image, customerId: widget.customerId, scheduleId: widget.scheduleId),
                                    );
                                  }
                                  // Step 4: submit
                                  if (action == CustomerUploadFotoAction.submit) {
                                    // Refresh detail after successful upload
                                    provider.getDetailCustomer(widget.customerId, widget.scheduleId, context);
                                  }
                                } finally {
                                  provider.setLoadingImage(false);
                                }
                              },
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 12),
                    if (provider.isLoading == false)
                      Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: AppButton(
                              label: l.customerDetail_order,
                              type: AppButtonType.sky50,
                              height: 42,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => OrderScreen(customerDetailData: provider.customerDetailData))).then((
                                  value,
                                ) {
                                  // Pop value to refresh detail after order/payment
                                  if (value != null && value == 'refresh-quick-sales') {
                                    // Refresh detail after order/payment
                                    provider.getDetailCustomer(widget.customerId, widget.scheduleId, context);
                                    // Refresh inventory
                                    context.read<GeneralProviders>().getInventory(context);
                                    // Clear quick sales items
                                    context.read<QuickSalesProvider>().clearQuickSalesItems();
                                  } else if (value != null && value == 'refresh-sales-order') {
                                    // Refresh detail after order/payment
                                    provider.getDetailCustomer(widget.customerId, widget.scheduleId, context);
                                    // Refresh inventory
                                    context.read<GeneralProviders>().getInventory(context);
                                    // Clear general order items
                                    context.read<SalesOrderProvider>().clearSalesOrderItems();
                                  }
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: AppButton(
                              label: l.customerDetail_adjustment,
                              type: AppButtonType.sky50,
                              height: 42,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => AdjustmentScreen()));
                              },
                            ),
                          ),
                          Expanded(
                            child: AppButton(
                              label: l.customerDetail_return,
                              type: AppButtonType.sky50,
                              height: 42,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => ReturnScreen(customerDetailData: provider.customerDetailData))).then((
                                  value,
                                ) {
                                  // Pop value to refresh detail after return
                                  if (value != null && value == 'refresh-return-payment') {
                                    // Refresh detail after return
                                    provider.getDetailCustomer(widget.customerId, widget.scheduleId, context);
                                    // Refresh inventory
                                    context.read<GeneralProviders>().getInventory(context);
                                    // Clear return order items
                                    context.read<ReturnProvider>().clearReturnOrderItems();
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              DraggableScrollableSheetDetailCustomer(),
            ],
          );
        },
      ),
    );
  }

  Widget infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label2SemiBold.copyWith(color: AppColors.white)),
        Text(value, style: AppTextStyles.body3Regular.copyWith(color: AppColors.white)),
      ],
    );
  }

  Widget shimmerColumn() {
    return Shimmer(
      duration: const Duration(milliseconds: 1500),
      interval: const Duration(milliseconds: 300),
      colorOpacity: 0.0,
      enabled: true,
      direction: ShimmerDirection.fromLeftToRight(),
      child: Column(spacing: 12, crossAxisAlignment: CrossAxisAlignment.start, children: List.generate(6, (_) => shimmerItem())),
    );
  }

  Widget shimmerItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 14,
          width: 120,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(height: 6),
        Container(
          height: 14,
          width: 160,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(4)),
        ),
      ],
    );
  }

  Widget shimmerHeader() {
    return Shimmer(
      duration: const Duration(milliseconds: 1500),
      colorOpacity: 0.3,
      direction: ShimmerDirection.fromLeftToRight(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 20,
            width: 140,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(6)),
          ),
          Container(
            height: 20,
            width: 90,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(6)),
          ),
        ],
      ),
    );
  }
}
