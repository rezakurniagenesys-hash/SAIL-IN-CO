// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
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
                          stockProvider.getStock(context);
                        },
                      ),
                    ),
                  ],
                ),
                if (stockProvider.isLoadingStock == true) ...[
                  Expanded(child: const Center(child: CircularProgressIndicator())),
                ] else ...[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: stockProvider.stockItem?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ItemHistoryStock(stockItem: stockProvider.stockItem?[index]);
                    },
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
