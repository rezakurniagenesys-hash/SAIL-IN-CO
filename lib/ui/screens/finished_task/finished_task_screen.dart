// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/utils/debouncer.dart';
import 'package:sail_in_co/providers/customer/customer_management_provider.dart';
import 'package:sail_in_co/ui/screens/customer/components/item_customer.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_infinite_list.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';
import 'package:sail_in_co/ui/widgets/app_scan.dart';

class FinishedTaskScreen extends StatefulWidget {
  const FinishedTaskScreen({super.key});

  @override
  State<FinishedTaskScreen> createState() => _FinishedTaskScreenState();
}

class _FinishedTaskScreenState extends State<FinishedTaskScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController searchCtrl = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);

    /// Load pertama
    Future.microtask(() {
      context.read<CustomerManagementProvider>().getCustomers();
    });

    tabController.addListener(() {
      if (tabController.indexIsChanging) return;

      final provider = context.read<CustomerManagementProvider>();
      provider.clearData();
      switch (tabController.index) {
        case 0:
          provider.applyFilter(status: null, search: searchCtrl.text); // ALL
          break;
        case 1:
          provider.applyFilter(status: 0, search: searchCtrl.text); // NOT VISIT
          break;
        case 2:
          provider.applyFilter(status: 1, search: searchCtrl.text); // VISIT
          break;
      }
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    tabController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBarCustom(
          title: 'Finished Task',
          onRefresh: () {
            final provider = context.read<CustomerManagementProvider>();
            provider.clearData();
            provider.getCustomers();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Daftar Pelanggan', style: AppTextStyles.body2Medium.copyWith(fontSize: 16)),
              Divider(color: AppColors.border),

              /// SEARCH + SCAN
              Row(
                children: [
                  Expanded(
                    child: AppInputField(
                      controller: searchCtrl,
                      hintText: 'Search',
                      onChanged: (text) {
                        _debouncer.run(() {
                          final provider = context.read<CustomerManagementProvider>();
                          provider.applyFilter(search: text);
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () async {
                      final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AppScan()));

                      if (result != null) {
                        searchCtrl.text = result;
                        final provider = context.read<CustomerManagementProvider>();
                        provider.applyFilter(search: result);
                        tabController.index = 0;
                      }
                    },
                    child: SvgPicture.asset(
                      AssetIcons.letsIconsUserScanFill,
                      height: 36,
                      colorFilter: const ColorFilter.mode(AppColors.sky950, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),

              /// TAB BAR
              TabBar(
                controller: tabController,
                labelColor: AppColors.sky700,
                unselectedLabelColor: AppColors.neutral400,
                labelStyle: AppTextStyles.label2SemiBold,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: AppColors.sky700),
                  insets: EdgeInsets.zero,
                ),
                tabs: const [
                  Tab(text: "All"),
                  Tab(text: "Not Visit"),
                  Tab(text: "Visit"),
                ],
              ),

              /// TAB VIEW
              Expanded(
                child: TabBarView(controller: tabController, children: [_buildList(), _buildList(), _buildList()]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ------------------------ UI: LIST ------------------------
  Widget _buildList() {
    return Consumer<CustomerManagementProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async => provider.getCustomers(),
          child: AppInfinityList(
            items: provider.customers,
            isLoading: provider.isLoading,
            isLoadMore: provider.isLoadMore,
            onLoadMore: () => provider.getCustomers(loadMore: true),
            itemBuilder: (context, index) {
              return ItemCustomer(customer: provider.customers[index]);
            },
          ),
        );
      },
    );
  }
}
