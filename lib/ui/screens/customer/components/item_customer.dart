import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/data/models/customer/customer_item.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';

class ItemCustomer extends StatelessWidget {
  const ItemCustomer({super.key, this.date = '', this.statusPayment = '', this.customer, required this.onTap});
  final CustomerItem? customer;
  final String date;
  final String statusPayment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.neutral100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.neutral300),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (date.isNotEmpty)
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Text(date, style: AppTextStyles.body2Medium),
              ),
            Expanded(
              child: Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          customer?.nmAcc6 ?? '-',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.body2Medium.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(color: (customer?.statusVisit == 2) ? AppColors.success : AppColors.error, shape: BoxShape.circle),
                          ),
                          SizedBox(width: 4),
                          Text(
                            customer?.statusVisit == 1
                                ? l!.customer_failedNotVisit
                                : customer?.statusVisit == 2
                                ? l!.customer_visit
                                : l!.customer_notVisit,
                            style: AppTextStyles.body4Reguler.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Text(customer?.address ?? '-', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
                  Text(
                    customer?.address ?? '-',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary),
                  ),
                  if (statusPayment.isNotEmpty) Text(statusPayment, style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
                  Text(customer?.phone ?? '-', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
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
      ),
    );
  }
}
