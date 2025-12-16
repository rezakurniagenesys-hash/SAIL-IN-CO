import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/data/models/history/sales_order_response_model.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';

class ItemOutstandingOrder extends StatelessWidget {
  const ItemOutstandingOrder({super.key, this.item, this.onView, this.onPayment, this.onShipping, this.onPrint, this.onDelete});
  final SalesOrderModel? item;
  final VoidCallback? onView;
  final VoidCallback? onPayment;
  final VoidCallback? onShipping;
  final VoidCallback? onPrint;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 8),
          child: Text(formatDate(DateTime.parse(item?.salesOrderDate ?? DateTime.now().toIso8601String())), style: AppTextStyles.body2Medium),
        ),
        Expanded(
          child: Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item?.salesOrderId ?? '-', style: AppTextStyles.body2Medium),
                  Row(
                    children: [
                      Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(color: (item?.isShipped == 1) ? AppColors.green : AppColors.error, shape: BoxShape.circle),
                      ),
                      SizedBox(width: 4),
                      Text(
                        (item?.isShipped == 1) ? l?.customerDetail_delivered ?? '' : l?.customerDetail_notDelivered ?? '',
                        style: AppTextStyles.body4Reguler.copyWith(color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ],
              ),
              if (item?.isShipped == 0) Text(l?.order_waitingForShipping ?? '', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
              if (item?.isShipped == 1)
                Text("${l?.customerDetail_shipping ?? ''} | ${item?.shippingId}", style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
              SizedBox(height: 4),
              Row(
                spacing: 6,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildButton(AssetIcons.carbonViewFilled, onView ?? () {}, true),
                  buildButton(AssetIcons.materialSymbolsLocalShippingRounded, (item?.isShipped == 1 ? null : onShipping) ?? () {}, item?.isShipped == 0),
                  buildButton(
                    AssetIcons.fluentPayment20Filled,
                    (item?.isShipped == 0 ? null : (item?.isPaid == 1 ? null : onPayment)) ?? () {},
                    item?.isShipped == 1 && item?.isPaid == 0,
                  ),
                  buildButton(AssetIcons.materialSymbolsPrintRounded, onPrint ?? () {}, true),
                  buildButton(AssetIcons.materialSymbolsDelete, onDelete ?? () {}, true, isDelete: true),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildButton(String icon, VoidCallback onTap, bool isActive, {bool isDelete = false, bool isDeleteLoading = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 24,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: isActive ? (isDelete ? AppColors.error : AppColors.sky700) : AppColors.grey),
        ),
        child: SvgPicture.asset(icon, color: isActive ? (isDelete ? AppColors.error : AppColors.sky700) : AppColors.grey, width: 20, height: 20),
      ),
    );
  }

  // Format date (DD/MM)
  String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    return '$day/$month';
  }
}
