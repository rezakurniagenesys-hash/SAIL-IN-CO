// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/connection_provider.dart';
import 'package:sail_in_co/providers/generals/general_providers.dart';
import 'package:sail_in_co/providers/home/home_provider.dart';
import 'package:sail_in_co/providers/sync/sync_provider.dart';
import 'package:sail_in_co/ui/screens/development/developer_offline_page.dart';
import 'package:sail_in_co/ui/screens/finished_task/finished_task_screen.dart';
import 'package:sail_in_co/ui/screens/home/components/header_home.dart';
import 'package:sail_in_co/ui/screens/home/components/sections_achievements.dart';
import 'package:sail_in_co/ui/screens/home/components/sections_petty_cash.dart';
import 'package:sail_in_co/ui/screens/home/components/sections_stock.dart';
import 'package:sail_in_co/ui/screens/home/components/sync_data_dialog_content.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_custom_loading_spinner.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';
import 'package:sail_in_co/ui/widgets/app_semi_doughnut_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    /// Jalankan setelah frame pertama dirender
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// Load first data
      context.read<HomeProvider>().init(context);
      context.read<GeneralProviders>().getInventory(context);

      final syncProvider = context.read<SyncProvider>();
      syncProvider.init(
        onShowLoading: () => showLoading(),
        onHideLoading: () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        },
      );

      /// Tampilkan popup Sync Data
      // showSyncDataDialog();
    });
  }

  // ------------------------------
  // Dialog Sync Data
  // ------------------------------
  void showSyncDataDialog() {
    final l = AppLocalizations.of(context);

    final syncProvider = context.read<SyncProvider>();

    AppDialog.show(
      context: context,
      isBack: false,
      title: l!.homeDialog_syncTitle,
      content: const SyncDataDialogContent(),
      actionButton: AppButton(
        isFullWidth: true,
        label: l.homeDialog_syncButton,
        height: 42,
        type: AppButtonType.primary,
        onPressed: () {
          Navigator.pop(context);

          /// Sync init
          syncProvider.init(
            onShowLoading: () => showLoading(),
            onHideLoading: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  // ------------------------------
  // Dialog Loading
  // ------------------------------
  void showLoading() {
    final l = AppLocalizations.of(context);

    AppDialog.show(
      context: context,
      isBack: false,
      title: l!.homeDialog_syncTitle,
      content: Column(
        spacing: 16,
        children: [
          const AppCustomLoadingSpinner(),
          Text(l.homeDialog_syncNote, style: AppTextStyles.body3Regular, textAlign: TextAlign.center),
        ],
      ),
    );

    /// Tutup otomatis setelah 3 detik
    // Future.delayed(const Duration(seconds: 3), () {
    //   if (Navigator.canPop(context)) Navigator.pop(context);
    // });
  }

  // ------------------------------
  // UI
  // ------------------------------
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      // button pojok kanan
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const DeveloperOfflinePage()));
        },
        backgroundColor: AppColors.warning,
        child: const Icon(Icons.developer_mode),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Consumer<ConnectionProvider>(
            builder: (context, connectionProvider, child) {
              return HeaderHome(isOnline: connectionProvider.isConnected);
            },
          ),
        ),
        backgroundColor: AppColors.sky950,
        toolbarHeight: 87,
        automaticallyImplyLeading: false,
      ),

      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Column(
            children: [
              // Banner offline
              Consumer<ConnectionProvider>(
                builder: (context, connectionProvider, child) {
                  return (!connectionProvider.isConnected)
                      ? Container(
                          width: double.infinity,
                          color: Color(0xFFFDF5D2),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              const Icon(Icons.wifi_off, color: Colors.black),
                              const SizedBox(width: 8),
                              Text(
                                l!.home_noInternet,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),

              // Content
              Expanded(
                child: LiquidPullToRefresh(
                  onRefresh: () async {
                    homeProvider.init(context);
                    context.read<GeneralProviders>().getInventory(context);
                    final syncProvider = context.read<SyncProvider>();
                    syncProvider.init(
                      onShowLoading: () => showLoading(),
                      onHideLoading: () {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                    );
                  },
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
                        // Task Chart
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FinishedTaskScreen())),
                            child: AppSemiDoughnutChart(
                              label: l?.home_tasks ?? '',
                              completed: homeProvider.summaryData?.completedTasks ?? 0,
                              pending: homeProvider.summaryData?.pendingTasks ?? 0,
                              total: homeProvider.summaryData?.totalTasks ?? 0,
                              isLoading: homeProvider.isLoading,
                            ),
                          ),
                        ),
                        const SectionsPettyCash(),

                        SectionsStockDashboard(stockItem: homeProvider.stockItem, isLoading: homeProvider.isLoadingStock),

                        const SectionsAchievementsDashboard(),
                        Container(color: AppColors.white, width: double.infinity, height: 200),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
