import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';

class ItemInventoryQuickSales extends StatelessWidget {
  const ItemInventoryQuickSales({super.key, this.isDescriptionVisible = false});
  final bool isDescriptionVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.neutral400, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rokok ABC', style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary)),
              Text('20 Pcs', style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rokok ABC',
                style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.normal),
              ),
              Text('Rp. 18.000', style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Disc',
                style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.normal),
              ),
              Text('- Rp. 1.000', style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary)),
            ],
          ),
          if (isDescriptionVisible)
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
              style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.neutral400, fontWeight: FontWeight.normal),
            ),
          const SizedBox(height: 4),
          Row(
            children: [
              AppButton(label: 'Edit', type: AppButtonType.warning, onPressed: () {}),
              const SizedBox(width: 8),
              AppButton(label: 'Hapus', type: AppButtonType.danger, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
