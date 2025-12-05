// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/data/models/stock/stock_response.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/screens/history_stock/history_stock_screen.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class SectionsStockDashboard extends StatelessWidget {
  const SectionsStockDashboard({super.key, this.stockItem, this.isLoading});
  final List<StockItem>? stockItem;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final displayList = stockItem?.take(5).toList() ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryStockScreen()));
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
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

              if (isLoading == true) ...List.generate(5, (index) => _ShimmerRow()),

              if (isLoading == false && stockItem != null && stockItem!.isNotEmpty) ...[
                ...displayList.asMap().entries.map((e) {
                  final idx = e.key + 1;
                  final item = e.value;
                  return _ItemStock(title: "$idx. ${item.inventoryName ?? '-'}", value: "${item.totalStock ?? 0} ${item.uomName ?? ''}");
                }),
              ],

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

  Widget _ShimmerRow() {
    return Shimmer(
      duration: const Duration(seconds: 2),
      color: Colors.grey.shade300,
      colorOpacity: 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 120,
            height: 14,
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)),
          ),
          Container(
            width: 80,
            height: 14,
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)),
          ),
        ],
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
