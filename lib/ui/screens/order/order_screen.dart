import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/order/quick_sales_provider.dart';
import 'package:sail_in_co/ui/screens/order/components/quick_sales.dart';
import 'package:sail_in_co/ui/screens/order/components/sales_order.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, this.customerDetailData});

  final CustomerDetailData? customerDetailData;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _titles = ['Quick Sales', 'Sales Order'];

  //   List<String> get _titles {
  //   final l = AppLocalizations.of(context)!;
  //   return [l.order_quickSales, l.order_salesOrder];
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<QuickSalesProvider>();
      provider.loadUserInfo();
    });
    _tabController = TabController(length: _titles.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: _titles[_tabController.index], onRefresh: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            // --- TabBar ---
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              labelColor: AppColors.sky700,
              unselectedLabelColor: AppColors.neutral400,
              dividerColor: Colors.transparent,
              labelStyle: AppTextStyles.label2SemiBold,
              tabs: [
                Tab(text: l!.order_quickSales),
                Tab(text: l.order_salesOrder),
              ],
            ),
            const SizedBox(height: 12),
            // --- Tab Content ---
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  QuickSales(customerDetailData: widget.customerDetailData),
                  SalesOrder(customerDetailData: widget.customerDetailData),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
