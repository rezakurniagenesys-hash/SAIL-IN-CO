// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/connection_provider.dart';
import 'package:sail_in_co/providers/home_provider.dart';
import 'package:sail_in_co/services/auth_service.dart';
import 'package:sail_in_co/services/locale_service.dart';
import 'package:sail_in_co/ui/screens/finished_task/finished_task_screen.dart';
import 'package:sail_in_co/ui/screens/home/components/header_home.dart';
import 'package:sail_in_co/ui/screens/home/components/sections_achievements.dart';
import 'package:sail_in_co/ui/screens/home/components/sections_stock.dart';
import 'package:sail_in_co/ui/screens/home/components/sync_data_dialog_content.dart';
import 'package:sail_in_co/ui/screens/login/login_screen.dart';
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
  double totalTask = 20;

  @override
  initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeProvider>().init();
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      // showSyncDataDialog();
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      totalTask = 0;
      showSyncDataDialog();
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      totalTask = 20;
    });
  }

  void showSyncDataDialog() {
    final l = AppLocalizations.of(context);
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
          showLoading();
        },
      ),
    );
  }

  void showLoading() {
    final l = AppLocalizations.of(context);
    AppDialog.show(
      context: context,
      isBack: false,
      title: l!.homeDialog_syncTitle,
      content: Column(
        spacing: 16,
        children: [
          AppCustomLoadingSpinner(),
          Text(l.homeDialog_syncNote, style: AppTextStyles.body3Regular, textAlign: TextAlign.center),
        ],
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
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
      body: Column(
        children: [
          Consumer<ConnectionProvider>(
            builder: (context, connectionProvider, child) {
              if (!connectionProvider.isConnected) {
                return Container(
                  width: double.infinity,
                  color: Colors.red.shade600,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    l!.home_noInternet,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          // SwitchListTile(
          //   title: Text(AppLocalizations.of(context)!.language),
          //   value: localeService.isEnglish,
          //   onChanged: (value) {
          //     localeService.switchLanguage(value ? 'en' : 'id');
          //   },
          // ),
          // Button logout
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                child: AppButton(
                  label: 'Logout',
                  height: 36,
                  type: AppButtonType.primary,
                  onPressed: () async {
                    // Logout
                    AuthService.clear();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                ),
              ),
            ],
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FinishedTaskScreen()));
                        },
                        child: AppSemiDoughnutChart(
                          value: totalTask,
                          label: l?.home_tasks ?? '',
                          number: totalTask.toStringAsFixed(0),
                          valueLeft: 2,
                          valueRight: 5,
                        ),
                      ),
                    ),
                    SectionsStockDashboard(),
                    SectionsAchievementsDashboard(),
                    Container(color: AppColors.white, width: double.infinity, height: 200),
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
