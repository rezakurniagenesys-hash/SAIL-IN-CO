import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/ui/screens/customer_detail/components/item_outstanding_order.dart';
import 'package:sail_in_co/ui/widgets/app_date_picker.dart';
import 'package:sail_in_co/ui/widgets/app_input_field.dart';

class OutstandingOrderScreen extends StatelessWidget {
  const OutstandingOrderScreen({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 24),
          Column(spacing: 18, children: List.generate(20, (i) => ItemOutstandingOrder())),
        ],
      ),
    );
  }
}
