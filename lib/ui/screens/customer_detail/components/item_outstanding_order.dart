import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class ItemOutstandingOrder extends StatelessWidget {
  const ItemOutstandingOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 8),
          child: Text('11/08', style: AppTextStyles.body2Medium),
        ),
        Expanded(
          child: Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('QS.0123123.1231321', style: AppTextStyles.body2Medium),
                  Row(
                    children: [
                      Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                      ),
                      SizedBox(width: 4),
                      Text('Not Delivered', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.textPrimary)),
                    ],
                  ),
                ],
              ),
              Text('Waiting for payment', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
              SizedBox(height: 8),
              Row(
                spacing: 6,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildButton(AssetIcons.carbonViewFilled, () {}, true),
                  buildButton(AssetIcons.fluentPayment20Filled, () {}, false),
                  buildButton(AssetIcons.materialSymbolsLocalShippingRounded, () {}, false),
                  buildButton(AssetIcons.materialSymbolsPrintRounded, () {}, true),
                  buildButton(AssetIcons.materialSymbolsDelete, () {}, false),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildButton(String icon, VoidCallback onTap, bool isActive) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 24,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: isActive ? AppColors.sky700 : AppColors.grey),
        ),
        child: SvgPicture.asset(icon, color: isActive ? AppColors.sky700 : AppColors.grey, width: 20, height: 20),
      ),
    );
  }
}
