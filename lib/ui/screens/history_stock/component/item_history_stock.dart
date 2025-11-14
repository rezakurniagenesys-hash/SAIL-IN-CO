import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class ItemHistoryStock extends StatelessWidget {
  const ItemHistoryStock({super.key});

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
                    Text('Order Stock', style: AppTextStyles.body2Medium),
                    Text('Qty', style: AppTextStyles.body2Medium),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('S.0123123.1231321', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
                    Text('25 Box', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
                  ],
                ),
                Text('Rokok Surya', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
                Text('01 Oktober 2025 17:23 WIB', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
