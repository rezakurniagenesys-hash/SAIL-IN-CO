// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/utils/debouncer.dart';
import 'package:sail_in_co/providers/sales/sales_provider.dart';
import 'package:sail_in_co/ui/screens/customer_detail/components/item_outstanding_order.dart';
import 'package:sail_in_co/ui/screens/customer_detail/sub_feature/view_outstanding_order_screen.dart';
import 'package:sail_in_co/ui/screens/payment/enums/payments_enum.dart';
import 'package:sail_in_co/ui/screens/payment/payment_screen.dart';
import 'package:sail_in_co/ui/widgets/app_date_picker.dart';
import 'package:sail_in_co/ui/widgets/app_infinite_list.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class OutstandingOrderPage extends StatefulWidget {
  const OutstandingOrderPage({super.key});

  @override
  State<OutstandingOrderPage> createState() => _OutstandingOrderPageState();
}

class _OutstandingOrderPageState extends State<OutstandingOrderPage> {
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provider = context.read<SalesProvider>();
      provider.clearData();
      provider.getOutstandingSalesOrders(initial: true);
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
                controller: provider.searchController,
                onChanged: (value) {
                  _debouncer.run(() {
                    provider.searchOutstandingSalesOrders(value);
                  });
                },
              ),
            ),
            SizedBox(width: 8),
            InkWell(
              onTap: () async {
                final date = await showAppDatePicker(context);
                if (date != null) {
                  print("Tanggal dipilih: $date");
                }
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
          onRefresh: () async => provider.getOutstandingSalesOrders(initial: true),
          child: AppInfinityList(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            items: provider.dataSalesOrder,
            isLoading: provider.isLoading,
            isLoadMore: provider.isLoadMore,
            onLoadMore: () => provider.getOutstandingSalesOrders(loadMore: true),
            itemBuilder: (context, index) {
              return ItemOutstandingOrder(
                item: provider.dataSalesOrder[index],
                onView: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewOutstandingOrderScreen(salesOrderId: provider.dataSalesOrder[index].salesOrderId)),
                  );
                },
                onShipping: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewOutstandingOrderScreen(salesOrderId: provider.dataSalesOrder[index].salesOrderId, isShippingOrder: true),
                    ),
                  ).then((value) {
                    if (value == 'refresh-shipping-order') {
                      provider.getOutstandingSalesOrders(initial: true);
                    }
                  });
                },
                onPayment: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(paymentType: PaymentType.outstandingOrderPayment))).then((
                    value,
                  ) {
                    // if (value == 'refresh-payment-order') {
                    //   provider.getOutstandingSalesOrders(initial: true);
                    // }
                  });
                },
              );
            },
          ),
        );
      },
    );
  }
}
