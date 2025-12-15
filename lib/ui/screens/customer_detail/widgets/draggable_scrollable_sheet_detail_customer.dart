import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/customer/customer_detail_provider.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/activity_history_screen.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/outstanding_order_screen.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/stock_history_screen.dart';
import 'package:sail_in_co/ui/widgets/app_draggable_scrollable_sheet.dart';

class DraggableScrollableSheetDetailCustomer extends StatefulWidget {
  const DraggableScrollableSheetDetailCustomer({super.key, required this.customerId});

  final String customerId;

  @override
  State<DraggableScrollableSheetDetailCustomer> createState() => _DraggableScrollableSheetDetailCustomerState();
}

class _DraggableScrollableSheetDetailCustomerState extends State<DraggableScrollableSheetDetailCustomer> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  CustomerDetailProvider? _provider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider = context.read<CustomerDetailProvider>();

    if (_provider != provider) {
      _provider = provider;

      // sync awal
      _tabController.index = provider.currentIndex;

      provider.addListener(_onProviderTabChanged);
    }
  }

  void _onProviderTabChanged() {
    final targetIndex = _provider!.currentIndex;
    if (_tabController.index != targetIndex) {
      _tabController.animateTo(targetIndex);
    }
  }

  @override
  void dispose() {
    _provider?.removeListener(_onProviderTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return AppDraggableScrollableSheet(
      initialChildSize: 0.40,
      minChildSize: 0.40,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- TAB BAR ----------------
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: AppColors.sky700,
                unselectedLabelColor: AppColors.neutral400,
                dividerColor: Colors.transparent,
                labelStyle: AppTextStyles.label2SemiBold,
                onTap: (index) {
                  context.read<CustomerDetailProvider>().setTab(index);
                },
                tabs: [
                  Tab(text: l.customerDetail_activityHistory),
                  Tab(text: l.customerDetail_sales),
                  Tab(text: l.customerDetail_stock),
                ],
              ),

              const SizedBox(height: 12),

              // ---------------- TAB VIEW ----------------
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ActivityHistoryScreen(scrollController: scrollController, customerId: widget.customerId),
                    OutstandingOrderScreen(scrollController: scrollController, customerId: widget.customerId),
                    StockHistoryScreen(scrollController: scrollController),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
