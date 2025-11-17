import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/ui/screens/customer/components/item_customer.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class FinishedTaskScreen extends StatelessWidget {
  const FinishedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBarCustom(title: 'Finished Task', onRefresh: () {}),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text('Daftar Pelanggan', style: AppTextStyles.body2Medium.copyWith(fontSize: 16)),
              Divider(color: AppColors.border),

              /// SEARCH & SCAN BUTTON
              Row(
                children: [
                  Expanded(
                    child: AppInputField(
                      hintText: 'Search',
                      controller: TextEditingController(),
                      onChanged: (value) {
                        // Handle search
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () async {
                      // final date = await showAppDatePicker(context);
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
                labelColor: AppColors.sky700,
                unselectedLabelColor: AppColors.neutral400,
                labelStyle: AppTextStyles.label2SemiBold,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: AppColors.sky700),
                  insets: EdgeInsets.zero, // no padding -> full tab width
                ),
                tabs: const [
                  Tab(text: "All"),
                  Tab(text: "Not Visit"),
                  Tab(text: "Visit"),
                ],
              ),

              /// TAB VIEW
              Expanded(
                child: TabBarView(
                  children: [
                    /// ALL
                    ListView.builder(itemCount: 10, padding: EdgeInsets.zero, itemBuilder: (context, index) => ItemCustomer()),

                    /// NOT VISIT
                    ListView.builder(itemCount: 5, padding: EdgeInsets.zero, itemBuilder: (context, index) => ItemCustomer()),

                    /// VISIT
                    ListView.builder(itemCount: 7, padding: EdgeInsets.zero, itemBuilder: (context, index) => ItemCustomer()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
