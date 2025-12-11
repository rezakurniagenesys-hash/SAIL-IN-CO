import 'package:flutter/material.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_customer_item_dao.dart';
import 'package:sail_in_co/data/models/customer/customer_item.dart';
import 'package:sail_in_co/ui/screens/development/customer_detail_offline_page.dart';

class CallsheetCustomerOfflinePage extends StatefulWidget {
  const CallsheetCustomerOfflinePage({super.key});

  @override
  State<CallsheetCustomerOfflinePage> createState() => _CallsheetCustomerOfflinePageState();
}

class _CallsheetCustomerOfflinePageState extends State<CallsheetCustomerOfflinePage> {
  final dao = CallsheetCustomerItemDao();

  bool loading = true;
  List<CustomerItem> items = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => loading = true);

    items = await dao.getCustomers();

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Callsheet Customer Offline")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadData,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text("Total Customer: ${items.length}", style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 10),

                  if (items.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text("- No Offline Customer Data -", style: TextStyle(color: Colors.black54)),
                      ),
                    )
                  else
                    ...items.map((item) => _customerCard(item)).toList(),
                ],
              ),
            ),
    );
  }

  Widget _customerCard(CustomerItem item) {
    return GestureDetector(
      onTap: () {
        // ===============================
        // GO TO DETAIL CUSTOMER OFFLINE
        // ===============================
        Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerDetailOfflinePage(customerId: item.noAcc6 ?? "")));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Text(item.nmAcc6 ?? "-", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),

              const SizedBox(height: 6),

              // No ACC
              Text("No ACC: ${item.noAcc6 ?? '-'}", style: const TextStyle(fontSize: 14, color: Colors.black87)),

              const SizedBox(height: 8),

              // Address
              _infoRow("Address", item.address),
              const SizedBox(height: 4),

              // Phone
              _infoRow("Phone", item.phone),
              const SizedBox(height: 4),

              // Status Visit
              _infoRow("Status Visit", item.statusVisit?.toString()),
              const SizedBox(height: 4),

              // Schedule ID
              _infoRow("Schedule ID", item.scheduleId),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text("$label:", style: const TextStyle(color: Colors.black54)),
        ),
        Expanded(child: Text(value?.isNotEmpty == true ? value! : "-", style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
