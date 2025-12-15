// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/utils/debouncer.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/history/activity_history_provider.dart';
import 'package:sail_in_co/ui/screens/customer_detail/components/item_activity_history.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_date_picker.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';
import 'package:sail_in_co/ui/widgets/app_horizontal_menu_tab.dart';
import 'package:sail_in_co/ui/widgets/app_infinite_list.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class ActivityHistoryScreen extends StatefulWidget {
  const ActivityHistoryScreen({super.key, required this.scrollController, required this.customerId});
  final ScrollController scrollController;
  final String? customerId;

  @override
  State<ActivityHistoryScreen> createState() => _ActivityHistoryScreenState();
}

class _ActivityHistoryScreenState extends State<ActivityHistoryScreen> {
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provider = context.read<ActivityHistoryProvider>();
      provider.clearData();
      // provider.getActivityHistory(initial: true, customerId: widget.customerId ?? '');
      provider.setSelectedActivityType(ActivityType.all, widget.customerId ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Consumer<ActivityHistoryProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          controller: widget.scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppInputField(
                      controller: provider.searchController,
                      onChanged: (value) {
                        _debouncer.run(() {
                          provider.searchActivityHistory(value, widget.customerId ?? '');
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () async {
                      AppDialog.show(
                        context: context,
                        title: 'Filter Date',
                        content: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: AppInputField(
                                    controller: provider.startDateController,
                                    hintText: 'Start Date',
                                    // readOnly: true,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        AssetIcons.icRoundDateRange,
                                        height: 16,
                                        colorFilter: const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
                                      ),
                                    ),
                                    onTap: () async {
                                      final date = await showAppDatePicker(context);
                                      if (date != null) {
                                        provider.setStartDate(date);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: AppInputField(
                                    hintText: 'End Date',
                                    controller: provider.endDateController,
                                    // readOnly: true,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        AssetIcons.icRoundDateRange,
                                        height: 16,
                                        colorFilter: const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
                                      ),
                                    ),
                                    onTap: () async {
                                      final date = await showAppDatePicker(context);
                                      if (date != null) {
                                        provider.setEndDate(date);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        actionButton: AppButton(
                          label: 'Filter',
                          isFullWidth: true,
                          type: AppButtonType.primary,
                          height: 42,
                          onPressed: () {
                            provider.filterDate(widget.customerId ?? '');
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                    child: SvgPicture.asset(AssetIcons.icRoundDateRange, height: 28, colorFilter: const ColorFilter.mode(AppColors.sky950, BlendMode.srcIn)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AppHorizontalMenuTab(
                tabs: [
                  l!.customerDetail_filterAll,
                  l.customerDetail_filterSales,
                  //  l.customerDetail_order, l.customerDetail_adjustment,
                  l.customerDetail_return,
                ],
                initialValue: l.customerDetail_filterAll,
                onChanged: (value) {
                  if (value == l.customerDetail_filterAll) {
                    provider.setSelectedActivityType(ActivityType.all, widget.customerId ?? '');
                  } else if (value == l.customerDetail_filterSales) {
                    provider.setSelectedActivityType(ActivityType.sales, widget.customerId ?? '');
                  }
                  // else if (value == l.customerDetail_order) {
                  //   provider.setSelectedActivityType(ActivityType.sales, widget.customerId ?? '');
                  // } else if (value == l.customerDetail_adjustment) {
                  //   provider.setSelectedActivityType(ActivityType.sales, widget.customerId ?? '');
                  // }
                  else if (value == l.customerDetail_return) {
                    provider.setSelectedActivityType(ActivityType.returns, widget.customerId ?? '');
                  }
                },
              ),
              const SizedBox(height: 12),
              // Column(spacing: 18, children: List.generate(20, (i) => ItemActivityHistory())),
              _buildList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildList() {
    return Consumer<ActivityHistoryProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: () async => provider.getActivityHistory(initial: true, customerId: widget.customerId ?? ''),
          child: AppInfinityList(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            items: provider.dataActivityHistory,
            isLoading: provider.isLoading,
            isLoadMore: provider.isLoadMore,
            onLoadMore: () => provider.getActivityHistory(loadMore: true, customerId: widget.customerId ?? ''),
            itemBuilder: (context, index) {
              final item = provider.dataActivityHistory[index];
              return ItemActivityHistory(item: item);
            },
          ),
        );
      },
    );
  }
}
