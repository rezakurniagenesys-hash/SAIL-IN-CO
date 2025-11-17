import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/screens/customer_detail/components/item_activity_history.dart';
import 'package:sail_in_co/ui/widgets/app_date_picker.dart';
import 'package:sail_in_co/ui/widgets/app_horizontal_menu_tab.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class ActivityHistoryScreen extends StatelessWidget {
  const ActivityHistoryScreen({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return SingleChildScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppInputField(
                  controller: TextEditingController(),
                  onChanged: (value) {
                    // Handle search logic here
                  },
                ),
              ),
              SizedBox(width: 8),
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
          const SizedBox(height: 12),
          AppHorizontalMenuTab(
            tabs: [l!.customerDetail_filterAll, l.customerDetail_filterSales, l.customerDetail_order, l.customerDetail_adjustment, l.customerDetail_return],
            initialValue: l.customerDetail_filterAll,
            onChanged: (value) {
              print('Selected tab: $value');
            },
          ),
          const SizedBox(height: 12),
          Column(spacing: 18, children: List.generate(20, (i) => ItemActivityHistory())),
        ],
      ),
    );
  }
}
