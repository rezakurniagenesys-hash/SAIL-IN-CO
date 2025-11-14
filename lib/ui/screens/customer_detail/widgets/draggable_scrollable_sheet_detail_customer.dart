import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/activity_history_screen.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/outstanding_order_screen.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/stock_history_screen.dart';
import 'package:sail_in_co/ui/widgets/app_draggable_scrollable_sheet.dart';

class DraggableScrollableSheetDetailCustomer extends StatelessWidget {
  const DraggableScrollableSheetDetailCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDraggableScrollableSheet(
      initialChildSize: 0.53,
      minChildSize: 0.53,
      builder: (context, scrollController) {
        return DefaultTabController(
          length: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              children: [
                // --- TabBar ---
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelColor: AppColors.sky700,
                  unselectedLabelColor: AppColors.neutral400,
                  dividerColor: Colors.transparent,
                  labelStyle: AppTextStyles.label2SemiBold,
                  tabs: const [
                    Tab(text: "Activity History"),
                    Tab(text: "Outstanding Order"),
                    Tab(text: "Stock"),
                  ],
                ),
                const SizedBox(height: 12),

                // --- Tab Content ---
                Expanded(
                  child: TabBarView(
                    children: [
                      ActivityHistoryScreen(scrollController: scrollController),
                      OutstandingOrderScreen(scrollController: scrollController),
                      StockHistoryScreen(scrollController: scrollController),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
