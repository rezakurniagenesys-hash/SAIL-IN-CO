import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/data/models/history/sales_history_response_model.dart';

class ItemHistorySales extends StatelessWidget {
  const ItemHistorySales({super.key, this.item, this.onView, this.onPrint, this.onDelete});
  final SalesHistoryItem? item;
  final VoidCallback? onView;
  final VoidCallback? onPrint;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 8),
          child: Text(formatDate(DateTime.parse(item?.transactionDate ?? DateTime.now().toIso8601String())), style: AppTextStyles.body2Medium),
        ),
        Expanded(
          child: Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item?.transactionId ?? '-', style: AppTextStyles.body2Medium),
              Text('Paid', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
              Row(
                spacing: 6,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildButton(AssetIcons.carbonViewFilled, onView ?? () {}, true),

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
