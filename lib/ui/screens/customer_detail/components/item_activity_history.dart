import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/utils/currency_format.dart';
import 'package:sail_in_co/data/models/history/activity_history_response_model.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';

class ItemActivityHistory extends StatelessWidget {
  const ItemActivityHistory({super.key, required this.item});
  final ActivityHistoryTransaction item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Text(formatDate(DateTime.parse(item.transactionDate)), style: AppTextStyles.body2Medium),
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
                          // Text('Quick Sales', style: AppTextStyles.body2Medium),
                          // Text(' | ', style: AppTextStyles.body2Medium),
                          Text(item.salesId, style: AppTextStyles.body2Medium),
                        ],
                      ),
                      Text(CurrencyFormat.toRupiah(item.grandTotal), style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                  Text(item.inventoryNames ?? '-', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textPrimary)),
                  Text(
                    '${AppLocalizations.of(context)!.order_lastUpdated}: ${item.lastUpdate}',
                    style: AppTextStyles.body4Reguler.copyWith(color: AppColors.textSecondary),
                  ),
                  if (item.salesId.startsWith('SO'))
                    Text(
                      item.shippingId != null ? item.shippingId! : AppLocalizations.of(context)!.order_waitingForShipping,
                      style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary),
                    ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
      ],
    );
  }

  // Format date (DD/MM)
  String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    return '$day/$month';
  }
}
