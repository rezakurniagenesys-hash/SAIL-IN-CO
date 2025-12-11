import 'package:flutter/material.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_customer_detail_dao.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';

class CustomerDetailOfflinePage extends StatefulWidget {
  final String customerId;

  const CustomerDetailOfflinePage({
    super.key,
    required this.customerId,
  });

  @override
  State<CustomerDetailOfflinePage> createState() => _CustomerDetailOfflinePageState();
}

class _CustomerDetailOfflinePageState extends State<CustomerDetailOfflinePage> {
  final dao = CustomerDetailDao();

  bool loading = true;
  CustomerModel? detail;

  @override
  void initState() {
    super.initState();
    loadDetail();
  }

  Future<void> loadDetail() async {
    setState(() => loading = true);

    detail = await dao.getCustomerDetail(
      widget.customerId,
    );

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Detail Offline"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : detail == null
              ? _emptyState()
              : _detailView(),
    );
  }

  Widget _emptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Text(
          "- No Customer Detail Saved Offline -",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _detailView() {
    return RefreshIndicator(
      onRefresh: loadDetail,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAME
                  Text(
                    detail?.name ?? "-",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),

                  // CUSTOMER ID
                  Text(
                    "No ACC: ${detail?.noAcc6 ?? '-'}",
                    style: const TextStyle(fontSize: 15),
                  ),

                  const Divider(height: 30),

                  // ADDRESS
                  _infoRow("Address", detail?.address),
                  const SizedBox(height: 8),

                  // PHONE
                  _infoRow("Phone", detail?.phone),
                  const SizedBox(height: 8),

                  // VISIT STATUS
                  _infoRow("Visit Status", detail?.statusVisit?.toString()),
                  const SizedBox(height: 8),

                  // SCHEDULE ID
                  _infoRow("status Visit", detail?.statusVisit?.toString()),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // PAGE INFO
          Text(
            "Offline Detail Loaded",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green.shade700),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            "$label:",
            style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Text(
            value?.isNotEmpty == true ? value! : "-",
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
