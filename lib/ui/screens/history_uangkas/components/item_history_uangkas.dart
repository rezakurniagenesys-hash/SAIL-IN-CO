import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class ItemHistoryUangkas extends StatelessWidget {
  const ItemHistoryUangkas({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: AppColors.sky800, borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.person_2_outlined, color: AppColors.white),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bensin', style: AppTextStyles.body2Medium),
                    Text('- Rp 35,000.00', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
                  ],
                ),
                Text('S.0123123.1231321', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
                Text('Pembelian bensin pertamax', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
                Text('01 Oktober 2025 17:23 WIB', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
