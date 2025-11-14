import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key, required this.isOnline});
  final bool? isOnline;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      width: double.infinity,
      color: AppColors.sky950,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColors.neutral400),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Reza Kurnia Setiawan',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.heading5Bold.copyWith(color: AppColors.white),
                        ),
                        Text('rezakurniasetiawan@gmail.com', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.white)),
                        SizedBox(height: 4),
                        Text('Last Update : 03-11-2025', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Status', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.white)),
                Text(
                  isOnline == true ? 'Online' : 'Offline',
                  style: AppTextStyles.body3Medium.copyWith(color: isOnline == true ? AppColors.green : AppColors.error),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
