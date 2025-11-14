import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/ui/screens/transport/add_transport/add_transport_screen.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';
import 'package:sail_in_co/ui/widgets/app_dialog.dart';

class ItemTransportHistory extends StatelessWidget {
  const ItemTransportHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: AppColors.sky800, borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.person_2_outlined, color: AppColors.white),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bensin', style: AppTextStyles.body2Medium),
                    Text('- Rp 35,000.00', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
                  ],
                ),
                Text('S.0123123.1231321', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
                Text('Pembelian bensin pertamax', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
                Text('01 Oktober 2025 17:23 WIB', style: AppTextStyles.body4Reguler.copyWith(color: AppColors.neutral950)),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        AppDialog.show(context: context, title: 'View Transport Management', content: const AddTransportScreen());
                      },
                      child: Container(
                        width: 48,
                        height: 24,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.sky700, width: 1.5),
                        ),
                        child: SvgPicture.asset(AssetIcons.carbonViewFilled, color: AppColors.sky700, width: 20, height: 20),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        AppDialog.show(
                          context: context,
                          title: 'Edit Transport Management',
                          content: const AddTransportScreen(),
                          actionButton: AppButton(
                            isFullWidth: true,
                            label: 'Update',
                            height: 42,
                            type: AppButtonType.primary,
                            onPressed: () => Navigator.pop(context),
                          ),
                        );
                      },
                      child: Container(
                        width: 48,
                        height: 24,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.sky700, width: 1.5),
                        ),
                        child: SvgPicture.asset(AssetIcons.riEditFill, color: AppColors.sky700, width: 20, height: 20),
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 24,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.sky700, width: 1.5),
                      ),
                      child: SvgPicture.asset(AssetIcons.materialSymbolsDelete, color: AppColors.sky700, width: 20, height: 20),
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
