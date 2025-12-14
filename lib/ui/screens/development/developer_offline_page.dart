// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sail_in_co/ui/screens/development/callsheet_customer_offline_page.dart';
import 'package:sail_in_co/ui/screens/development/inventory_offline_page.dart';
import 'package:sail_in_co/ui/screens/development/payment_method_offline_page.dart';
import 'package:sail_in_co/ui/screens/development/quick_sales_offline_page.dart';
import 'package:sail_in_co/ui/screens/development/sales_order_offline_page.dart';
import 'package:sail_in_co/ui/screens/development/sales_return_offline_page.dart';
import 'package:sqflite/sqflite.dart';

import 'callsheet_offline_page.dart';
import 'stock_offline_page.dart';

class DeveloperOfflinePage extends StatefulWidget {
  const DeveloperOfflinePage({super.key});

  @override
  State<DeveloperOfflinePage> createState() => _DeveloperOfflinePageState();
}

class _DeveloperOfflinePageState extends State<DeveloperOfflinePage> {
  double dbSizeMB = 0.0;

  @override
  void initState() {
    super.initState();
    loadDbSize();
  }

  Future<void> loadDbSize() async {
    try {
      final path = await getDatabasesPath();
      final dbFile = File(p.join(path, "app.db"));

      if (await dbFile.exists()) {
        final bytes = await dbFile.length();
        setState(() {
          dbSizeMB = bytes / (1024 * 1024);
        });
      }
    } catch (e) {
      debugPrint("Error checking DB size: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("Developer Offline Tools"), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle("Offline Database Info"),

          _infoCard(icon: Icons.storage_outlined, title: "Offline Storage Size", value: "${dbSizeMB.toStringAsFixed(2)} MB"),

          const SizedBox(height: 24),
          _sectionTitle("Offline Data Viewer"),

          _menuItem(
            title: "Callsheet Summary Offline",
            subtitle: "Cek pending / completed tasks & last update",
            icon: Icons.list_alt,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CallsheetOfflinePage())),
          ),
          _menuItem(
            title: "Stock Offline Data",
            subtitle: "Cek daftar stock yang tersimpan di SQLite",
            icon: Icons.inventory_2_outlined,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StockOfflinePage())),
          ),
          _menuItem(
            title: "Inventory Offline Data",
            subtitle: "Cek daftar inventory yang tersimpan di SQLite",
            icon: Icons.inventory,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InventoryOfflinePage())),
          ),
          _menuItem(
            title: "Callsheet Customer Offline",
            subtitle: "Cek daftar customer callsheet yang tersimpan di SQLite",
            icon: Icons.group_outlined,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CallsheetCustomerOfflinePage())),
          ),
          _menuItem(
            title: "Payment Method Offline",
            subtitle: "Cek daftar payment method yang tersimpan di SQLite",
            icon: Icons.payment_outlined,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentMethodOfflinePage())),
          ),
          _menuItem(
            title: "Quick Sales Offline",
            subtitle: "Cek penjualan yang belum tersinkronisasi",
            icon: Icons.point_of_sale_outlined,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuickSalesOfflinePage())),
          ),
          _menuItem(
            title: "Sales Order Offline",
            subtitle: "Cek sales order yang belum tersinkronisasi",
            icon: Icons.shopping_cart_outlined,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SalesOrderOfflinePage()));
            },
          ),
          // Sales Return Offline
          _menuItem(
            title: "Sales Return Offline",
            subtitle: "Cek sales return yang belum tersinkronisasi",
            icon: Icons.assignment_return_outlined,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SalesReturnOfflinePage()));
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ================= UI COMPONENTS =================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _infoCard({required IconData icon, required String title, required String value}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Row(
        children: [
          Icon(icon, size: 36, color: Colors.blueAccent),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem({required String title, required String subtitle, required IconData icon, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 30, color: Colors.indigo),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 3),
                    Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.black45),
            ],
          ),
        ),
      ),
    );
  }
}
