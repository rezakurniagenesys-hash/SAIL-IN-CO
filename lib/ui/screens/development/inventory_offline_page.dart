import 'package:flutter/material.dart';

import 'package:sail_in_co/data/dao/master/inventory_dao.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_response.dart';

class InventoryOfflinePage extends StatefulWidget {
  const InventoryOfflinePage({super.key});

  @override
  State<InventoryOfflinePage> createState() => _InventoryOfflinePageState();
}

class _InventoryOfflinePageState extends State<InventoryOfflinePage> {
  final dao = InventoryItemDao();
  bool loading = true;

  List<InventoryItem> items = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() => loading = true);

    items = await dao.getInventoryItems();

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventory Offline")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text("Total Inventory: ${items.length}"),
                  const SizedBox(height: 12),

                  if (items.isEmpty)
                    const Center(
                      child: Padding(padding: EdgeInsets.only(top: 20), child: Text("- No Offline Inventory Data -")),
                    )
                  else
                    ...items.map(
                      (item) => Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 14),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Inventory Name
                              Text(
                                item.inventoryName,
                                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black87),
                              ),

                              const SizedBox(height: 10),

                              // Row info price & stock
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _infoTile("Price", _formatNumber(num.parse(item.price ?? ''))),
                                  _infoTile("Stock", _formatNumber(item.currentStock)),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // UOM Chips
                              if (item.uoms != null && item.uoms!.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "UOMs:",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                                    ),
                                    const SizedBox(height: 8),

                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 6,
                                      children: item.uoms!.map((uom) {
                                        return Chip(
                                          label: Text("${uom.uomName} (x${uom.value})"),
                                          backgroundColor: Colors.blue.shade50,
                                          labelStyle: const TextStyle(fontSize: 13, color: Colors.black87),
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                )
                              else
                                const Text("No UOM data", style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ],
    );
  }

  String _formatNumber(dynamic value) {
    if (value == null) return "0";

    // Convert to num safely
    num parsed;
    try {
      if (value is num) {
        parsed = value;
      } else {
        parsed = num.parse(value.toString());
      }
    } catch (_) {
      return "0";
    }

    // Format with thousand separator (dot)
    final parts = parsed.toString().split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : null;

    final formatted = integerPart.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => "${m[1]}.");

    // return with decimals if exists
    return decimalPart != null && decimalPart.isNotEmpty ? "$formatted,$decimalPart" : formatted;
  }
}
