import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/providers/connection_provider.dart';
import 'package:sail_in_co/ui/screens/customer/customer_screen.dart';
import 'package:sail_in_co/ui/screens/finished_task/finished_task_screen.dart';
import 'package:sail_in_co/ui/screens/home/components/header_home.dart';
import 'package:sail_in_co/ui/screens/home/components/sections_cash.dart';
import 'package:sail_in_co/ui/screens/home/components/sections_stock.dart';
import 'package:sail_in_co/ui/widgets/app_semi_doughnut_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalTask = 50;
  double finishedTask = 20;

  Future<void> _handleRefresh() async {
    // 1️⃣ Reset chart ke 0 (animasi turun)
    setState(() {
      totalTask = 0;
      finishedTask = 0;
    });

    // 2️⃣ Tunggu sejenak (simulasi fetch data)
    await Future.delayed(const Duration(seconds: 2));

    // 3️⃣ Naikkan kembali ke nilai sebenarnya
    setState(() {
      totalTask = 50;
      finishedTask = 20;
    });

    // 4️⃣ Notifikasi singkat
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = context.watch<ConnectionProvider>().isConnected;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        flexibleSpace: SafeArea(child: HeaderHome(isOnline: isConnected)),
        backgroundColor: AppColors.sky950,
        toolbarHeight: 87,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          if (!isConnected)
            Container(
              width: double.infinity,
              color: Colors.red.shade600,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Tidak ada koneksi internet',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: LiquidPullToRefresh(
              onRefresh: _handleRefresh,
              color: AppColors.sky950,
              backgroundColor: AppColors.white,
              height: 70,
              animSpeedFactor: 2.0,
              showChildOpacityTransition: false,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  spacing: 16,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerScreen()));
                              },
                              child: AppSemiDoughnutChart(value: totalTask, label: 'Customer', number: totalTask.toStringAsFixed(0), title: 'Total Task'),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => FinishedTaskScreen()));
                              },
                              child: AppSemiDoughnutChart(
                                value: finishedTask,
                                label: 'Customer',
                                number: finishedTask.toStringAsFixed(0),
                                title: 'Finished Task',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SectionsStockDashboard(),
                    SectionsCashDashboard(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
