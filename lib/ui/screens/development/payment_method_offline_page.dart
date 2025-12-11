import 'package:flutter/material.dart';
import 'package:sail_in_co/data/dao/master/method_payment_dao.dart';

import 'package:sail_in_co/data/models/payment/payment_method_response.dart';

class PaymentMethodOfflinePage extends StatefulWidget {
  const PaymentMethodOfflinePage({super.key});

  @override
  State<PaymentMethodOfflinePage> createState() => _PaymentMethodOfflinePageState();
}

class _PaymentMethodOfflinePageState extends State<PaymentMethodOfflinePage> {
  final MethodPaymentDao dao = MethodPaymentDao();
  List<PaymentMethodData> allItems = [];
  List<PaymentMethodData> filteredItems = [];

  final TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await dao.getPaymentMethods();
    setState(() {
      allItems = data;
      filteredItems = data;
    });
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() => filteredItems = allItems);
      return;
    }

    setState(() {
      filteredItems = allItems.where((item) {
        return item.slipName.toLowerCase().contains(query.toLowerCase()) ||
            item.slipId.toLowerCase().contains(query.toLowerCase()) ||
            item.slipType.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Method Offline")),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchCtrl,
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Cari slip name / slip id...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 2),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: loadData,
              child: filteredItems.isEmpty
                  ? const Center(
                      child: Text("Tidak ada data payment method.", style: TextStyle(fontSize: 15, color: Colors.black54)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return _paymentCard(item);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentCard(PaymentMethodData item) {
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
          _row("Slip ID", item.slipId),
          _row("Slip Name", item.slipName),
          _row("Slip Type", item.slipType),
          _row("Currency ID", item.currencyId),
          _row("Sales Acc Code", item.salesAccCode),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text("$label:", style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
