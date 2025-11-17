// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/screens/history_stock/history_stock_screen.dart';

class SectionsStockDashboard extends StatelessWidget {
  const SectionsStockDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryStockScreen()));
        },
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
              Text(l?.home_stock ?? '', style: AppTextStyles.heading6Bold),
              _ItemStock(title: '1. Rokok A', value: '1235 pcs'),
              _ItemStock(title: '2. Rokok B', value: '4353 pcs'),
              _ItemStock(title: '3. Rokok C', value: '8765 pcs'),
              _ItemStock(title: '4. Rokok D', value: '35433 pcs'),
              _ItemStock(title: '5. Rokok E', value: '1266435 pcs'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    l?.home_seeDetail ?? '',
                    style: AppTextStyles.body4Medium.copyWith(color: AppColors.neutral400, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_forward, color: AppColors.neutral400, size: 14),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ItemStock({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.body3Regular),
        Text(value, style: AppTextStyles.body3Regular),
      ],
    );
  }
}
