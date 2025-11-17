import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/screens/customer/components/item_customer.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_date_picker.dart';
import 'package:sail_in_co/ui/widgets/app_dropdown_field.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';
import 'package:sail_in_co/ui/widgets/app_horizontal_menu_tab.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? selectedCustomer;

  final List<String> customers = ['All Customers', 'Customer A', 'Customer B', 'Customer C'];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(title: l.transaction_transactionHistory, onRefresh: () {}, showBack: false),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppInputField(
                    label: l.transaction_search,
                    hintText: l.transaction_search,
                    controller: _searchController,
                    onChanged: (value) {
                      // handle search logic here
                    },
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () async {
                    final date = await showAppDatePicker(context);
                    if (date != null) {
                      print("Tanggal dipilih: $date");
                    }
                  },
                  child: SvgPicture.asset(AssetIcons.icRoundDateRange, height: 28, colorFilter: const ColorFilter.mode(AppColors.sky950, BlendMode.srcIn)),
                ),
              ],
            ),
            Row(
              children: [
                Text(l.transaction_customerFilter, style: AppTextStyles.body2Medium),
                const SizedBox(width: 12),
                Expanded(
                  child: AppDropdownField(
                    value: selectedCustomer,
                    items: customers,
                    onChanged: (value) {
                      setState(() {
                        selectedCustomer = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            AppHorizontalMenuTab(
              tabs: [l.transaction_all, l.transaction_sales, l.transaction_order, l.transaction_adjustment, l.transaction_return],
              initialValue: l.transaction_all,
              onChanged: (value) {
                print('Selected tab: $value');
              },
            ),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ItemCustomer(date: '06-0${index + 1}', statusPayment: index % 2 == 0 ? 'Paid' : 'Unpaid');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
