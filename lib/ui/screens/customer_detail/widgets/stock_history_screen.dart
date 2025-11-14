import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class StockHistoryScreen extends StatelessWidget {
  const StockHistoryScreen({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Column(
            spacing: 18,
            children: List.generate(
              20,
              (i) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rokok $i', style: AppTextStyles.body2Medium),
                  Text('25 Box', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
