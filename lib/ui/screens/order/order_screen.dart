import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/ui/screens/order/components/quick_sales.dart';
import 'package:sail_in_co/ui/screens/order/components/sales_order.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _titles = ['Quick Sales', 'Sales Order'];

  @override
  void initState() {
    super.initState();
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
              tabs: const [
                Tab(text: "Quick Sales"),
                Tab(text: "Sales Order"),
              ],
            ),
            const SizedBox(height: 12),
            // --- Tab Content ---
            Expanded(
              child: TabBarView(controller: _tabController, children: [QuickSales(), SalesOrder()]),
            ),
          ],
        ),
      ),
    );
  }
}
