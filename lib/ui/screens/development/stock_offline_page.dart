import 'package:flutter/material.dart';
import 'package:sail_in_co/data/dao/stock/stock_item_dao.dart';
import 'package:sail_in_co/data/models/stock/stock_response.dart';

class StockOfflinePage extends StatefulWidget {
  const StockOfflinePage({super.key});

  @override
  State<StockOfflinePage> createState() => _StockOfflinePageState();
}

class _StockOfflinePageState extends State<StockOfflinePage> {
  final dao = StockItemDao();
  bool loading = true;

  List<StockItem> stockItems = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() => loading = true);

    stockItems = await dao.getStockItems();

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stock Offline")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text("Total Items: ${stockItems.length}"),
                  const SizedBox(height: 12),

                  if (stockItems.isEmpty)
                    const Text("- No Offline Stock Data -")
                  else
                    ...stockItems.map(
                      (item) => Card(
                        child: ListTile(
                          title: Text(item.inventoryName ?? "-"),
                          subtitle: Text("${item.warehouseName ?? '-'} – ${item.totalStock} ${item.uomName}"),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
