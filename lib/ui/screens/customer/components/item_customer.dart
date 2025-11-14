import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/ui/screens/customer_detail/customer_detail_screen.dart';

class ItemCustomer extends StatelessWidget {
  const ItemCustomer({super.key, this.date = '', this.statusPayment = ''});
  final String date;
  final String statusPayment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerDetailScreen()));
      },
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
                      Text('Toko Bu Siti', style: AppTextStyles.body2Medium),
                      Row(
                        children: [
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                          ),
                          SizedBox(width: 4),
                          Text('Not Visited', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.textPrimary)),
                        ],
                      ),
                    ],
                  ),
                  Text('Jl. Merdeka No. 123, Jakarta', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
                  if (statusPayment.isNotEmpty) Text(statusPayment, style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
                  Text('08xxxxxxxxxx', style: AppTextStyles.body3Regular.copyWith(color: AppColors.textSecondary)),
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
