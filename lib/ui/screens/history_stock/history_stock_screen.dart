// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/utils/debouncer.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/stock/stock_provider.dart';
import 'package:sail_in_co/ui/screens/history_stock/component/item_history_stock.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class HistoryStockScreen extends StatefulWidget {
  const HistoryStockScreen({super.key});

  @override
  State<HistoryStockScreen> createState() => _HistoryStockScreenState();
}

class _HistoryStockScreenState extends State<HistoryStockScreen> {
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    Future.microtask(() {
      final provider = context.read<StockProvider>();
      provider.clear();
      provider.getStock(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(
        title: 'History Stock',
        onRefresh: () {
          final provider = context.read<StockProvider>();
          provider.clear();
          provider.getStock(context);
        },
      ),
      body: Consumer<StockProvider>(
        builder: (context, stockProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              spacing: 12,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppInputField(
                        hintText: 'Search',
                        controller: stockProvider.searchController,
                        onChanged: (value) {
                          _debouncer.run(() {
                            stockProvider.searchStock(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                if (stockProvider.isLoadingStock == true) ...[
                  Expanded(child: const Center(child: CircularProgressIndicator())),
                ] else if (stockProvider.stockItem == null || stockProvider.stockItem!.isEmpty) ...[
                  Expanded(
                    child: Center(
                      child: Text(l?.emptyState_noData ?? '', style: TextStyle(color: AppColors.neutral400, fontSize: 16)),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: stockProvider.stockItem?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ItemHistoryStock(stockItem: stockProvider.stockItem?[index]);
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
