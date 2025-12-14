import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/ui/screens/customer_detail/widgets/sales/outstanding_order_page.dart';

class OutstandingOrderScreen extends StatelessWidget {
  const OutstandingOrderScreen({super.key, required this.scrollController, required this.customerId});
  final ScrollController scrollController;
  final String customerId;

  @override
  Widget build(BuildContext context) {
    // 0 = Outstanding Orders, 1 = Sales
    final ValueNotifier<int> tabIndex = ValueNotifier<int>(0);

    return ValueListenableBuilder<int>(
      valueListenable: tabIndex,
      builder: (context, index, _) {
        return SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // TAB HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => tabIndex.value = 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: index == 0
                          ? BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColors.sky700, width: 2)),
                            )
                          : null,
                      child: Text(
                        'Outstanding Orders',
                        style: AppTextStyles.label2SemiBold.copyWith(color: index == 0 ? AppColors.sky700 : AppColors.neutral400),
                      ),
                    ),
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => tabIndex.value = 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: index == 1
                          ? BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColors.sky700, width: 2)),
                            )
                          : null,
                      child: Text('Sales', style: AppTextStyles.label2SemiBold.copyWith(color: index == 1 ? AppColors.sky700 : AppColors.neutral400)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // TAB CONTENT
              if (index == 0) OutstandingOrderPage(customerId: customerId),
              if (index == 1)
                SizedBox(
                  child: Text('Sales Page Coming Soon...', style: AppTextStyles.heading2Bold.copyWith(color: AppColors.textSecondary)),
                ),
            ],
          ),
        );
      },
    );
  }
}
