import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/generals/general_providers.dart';
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
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    /// Init TabController ONCE
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);

    /// Post frame async calls
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuickSalesProvider>().loadUserInfo();
      context.read<GeneralProviders>().getInventory(context);
      context.read<GeneralProviders>().getLockStock(context);
    });
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      setState(() {}); // update AppBar title
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  List<String> _titles(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return [l.order_quickSales, l.order_salesOrder];
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final titles = _titles(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: titles[_tabController.index], onRefresh: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            /// TAB BAR
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              labelColor: AppColors.sky700,
              unselectedLabelColor: AppColors.neutral400,
              dividerColor: Colors.transparent,
              labelStyle: AppTextStyles.label2SemiBold,
              tabs: [
                Tab(text: l.order_quickSales),
                Tab(text: l.order_salesOrder),
              ],
            ),
            const SizedBox(height: 12),

            /// TAB VIEW
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
