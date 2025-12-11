import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/utils/currency_format.dart';
import 'package:sail_in_co/data/models/general/order/general_order_draft_item.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';

class ItemInventoryQuickSales extends StatelessWidget {
  const ItemInventoryQuickSales({super.key, this.isDescriptionVisible = false, required this.item, this.onEdit, required this.onDelete});
  final bool isDescriptionVisible;
  final GeneralOrderDraftItem item;
  // onEdit bawa item
  final Function(GeneralOrderDraftItem item)? onEdit;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.neutral400, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.inventory.inventoryName, style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary)),
              Text('${item.qty2} ${item.uom.uomName}', style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l?.order_subTotalProduct ?? '',
                style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.normal),
              ),
              Text(CurrencyFormat.toRupiah(item.price * item.qty), style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l!.order_discount,
                style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.normal),
              ),
              Text(CurrencyFormat.toRupiah(item.discount * item.qty2), style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.textPrimary)),
            ],
          ),
          if (isDescriptionVisible)
            Text(
              item.notes,
              style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.neutral400, fontWeight: FontWeight.normal),
            ),
          const SizedBox(height: 4),
          Row(
            children: [
              AppButton(
                label: l.order_edit,
                type: AppButtonType.warning,
                onPressed: () {
                  if (onEdit != null) {
                    onEdit!(item);
                  }
                },
              ),
              const SizedBox(width: 8),
              AppButton(label: l.order_delete, type: AppButtonType.danger, onPressed: onDelete),
            ],
          ),
        ],
      ),
    );
  }
}
