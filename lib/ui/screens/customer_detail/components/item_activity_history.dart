import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class ItemActivityHistory extends StatelessWidget {
  const ItemActivityHistory({super.key});

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
                  Row(
                    children: [
                      Text('Quick Sales', style: AppTextStyles.body2Medium),
                      Text(' | ', style: AppTextStyles.body2Medium),
                      Text('QS.0123123.1231321', style: AppTextStyles.body2Medium),
                    ],
                  ),
                  Text('25 Box', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
                ],
              ),
              Text('Rokok ABC', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}
