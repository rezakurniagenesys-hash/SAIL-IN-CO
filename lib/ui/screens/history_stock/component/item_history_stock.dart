import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/data/models/stock/stock_response.dart';

class ItemHistoryStock extends StatelessWidget {
  const ItemHistoryStock({super.key, required this.stockItem});
  final StockItem? stockItem;

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
            child: SvgPicture.asset(AssetIcons.boxSolid, width: 24, fit: BoxFit.scaleDown),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(stockItem?.inventoryName ?? '', style: AppTextStyles.body2Medium),
                    Text('${stockItem?.totalStock ?? 0} ${stockItem?.uomName ?? ''}', style: AppTextStyles.body2Medium),
                  ],
                ),
                Text('${stockItem?.inventoryId}', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.sky950),
                      child: Icon(Icons.arrow_forward_ios_rounded, color: AppColors.white, size: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
