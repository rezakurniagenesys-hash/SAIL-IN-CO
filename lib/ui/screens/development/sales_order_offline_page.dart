import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sail_in_co/data/dao/sales/sales_order_dao.dart';

class SalesOrderOfflinePage extends StatefulWidget {
  const SalesOrderOfflinePage({super.key});

  @override
  State<SalesOrderOfflinePage> createState() => _SalesOrderOfflinePageState();
}

class _SalesOrderOfflinePageState extends State<SalesOrderOfflinePage> {
  final dao = SalesOrderDao();
  List<Map<String, dynamic>> sales = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final result = await dao.getPendingSalesOrders();
    setState(() {
      sales = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales Order Offline"),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: loadData)],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : sales.isEmpty
          ? const Center(child: Text("Tidak ada sales order offline 🎉"))
          : ListView.builder(padding: const EdgeInsets.all(16), itemCount: sales.length, itemBuilder: (_, i) => _salesCard(sales[i])),
    );
  }

  Widget _salesCard(Map<String, dynamic> row) {
    final details = jsonDecode(row['details_json']) as List;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row("Customer ID", row['customer_id']),
          _row("Sales Date", row['sales_order_date']),
          _row("Grand Total", row['grand_total'].toString()),
          _row("Payment Type", row['payment_type'].toString()),
          _row("Status Sync", _syncStatusText(row['sync_status'])),

          const SizedBox(height: 6),
          Text("Items: ${details.length}", style: const TextStyle(fontSize: 13, color: Colors.black54)),

          if (row['sync_error'] != null) ...[
            const SizedBox(height: 6),
            Text("Error: ${row['sync_error']}", style: const TextStyle(fontSize: 12, color: Colors.red)),
          ],
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  String _syncStatusText(int status) {
    switch (status) {
      case 0:
        return "Pending";
      case 2:
        return "Error";
      default:
        return "Unknown";
    }
  }
}
