// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/utils/debouncer.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/customer/customer_management_provider.dart';
import 'package:sail_in_co/ui/screens/customer/components/item_customer.dart';
import 'package:sail_in_co/ui/screens/customer_detail/customer_detail_screen.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_infinite_list.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';
import 'package:sail_in_co/ui/widgets/app_scan.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provider = context.read<CustomerManagementProvider>();
      provider.clearData();
      provider.getCustomers(initial: true);
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(
        title: l!.customer_title,
        onRefresh: () {
          final provider = context.read<CustomerManagementProvider>();
          searchCtrl.clear();
          provider.clearData();
          provider.getCustomers(initial: true);
        },
        showBack: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(l.customer_list, style: AppTextStyles.body2Medium.copyWith(fontSize: 16)),
            Divider(color: AppColors.border),
            Row(
              children: [
                Expanded(
                  child: AppInputField(
                    hintText: l.customer_search,
                    controller: searchCtrl,
                    onChanged: (text) {
                      _debouncer.run(() {
                        final provider = context.read<CustomerManagementProvider>();
                        provider.applyFilter(search: text);
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () async {
                    final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AppScan()));

                    if (result != null) {
                      searchCtrl.text = result;
                      final provider = context.read<CustomerManagementProvider>();
                      provider.applyFilter(search: result);
                    }
                  },
                  child: SvgPicture.asset(AssetIcons.letsIconsUserScanFill, height: 36, colorFilter: const ColorFilter.mode(AppColors.sky950, BlendMode.srcIn)),
                ),
              ],
            ),
            Expanded(child: _buildList()),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<CustomerManagementProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async => provider.getCustomers(initial: true),
          child: AppInfinityList(
            items: provider.customers,
            isLoading: provider.isLoading,
            isLoadMore: provider.isLoadMore,
            isSearchActive: searchCtrl.text.isNotEmpty,
            onLoadMore: () => provider.getCustomers(loadMore: true),
            itemBuilder: (context, index) {
              return ItemCustomer(
                customer: provider.customers[index],
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CustomerDetailScreen(customerId: provider.customers[index].noAcc6 ?? '', scheduleId: provider.customers[index].scheduleId ?? ''),
                    ),
                  ).then((_) {
                    // refresh data when back from detail screen
                    provider.getCustomers(initial: true);
                  });
                },
              );
            },
          ),
        );
      },
    );
  }
}
