// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class SectionsCashDashboard extends StatelessWidget {
  const SectionsCashDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey, width: 1),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 3))],
        ),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Stock', style: AppTextStyles.heading6Bold),
            Center(
              child: Text(
                'Rp 12,000,000.00',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2Bold.copyWith(color: AppColors.sky600),
              ),
            ),
            Text('History', style: AppTextStyles.body1Medium),
            _ItemStock(title: 'Transaksi Quick Sales', value: '- Rp 35,000.000'),
            _ItemStock(title: 'Penambahan Modal', value: '+ Rp 50,000.000'),
            _ItemStock(title: 'Pengambilan Pribadi', value: '- Rp 5,000.000'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Lihat Detail',
                  style: AppTextStyles.body4Medium.copyWith(color: AppColors.neutral400, fontWeight: FontWeight.w500),
                ),
                Icon(Icons.arrow_forward, color: AppColors.neutral400, size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _ItemStock({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.body3Medium),
        Text(value, style: AppTextStyles.body3Medium),
      ],
    );
  }
}
