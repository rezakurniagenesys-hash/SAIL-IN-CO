import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/activity_history_screen.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/outstanding_order_screen.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/stock_history_screen.dart';
import 'package:sail_in_co/ui/widgets/app_draggable_scrollable_sheet.dart';

class DraggableScrollableSheetDetailCustomer extends StatelessWidget {
  const DraggableScrollableSheetDetailCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AppDraggableScrollableSheet(
      initialChildSize: 0.40,
      minChildSize: 0.40,
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
                  tabs: [
                    Tab(text: l!.customerDetail_activityHistory),
                    Tab(text: l.customerDetail_outstandingOrder),
                    Tab(text: l.customerDetail_stock),
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
