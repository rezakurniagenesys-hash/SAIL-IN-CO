import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sail_in_co/core/constants/asset_icons.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/core/utils/currency_format.dart';

class SectionsPettyCash extends StatelessWidget {
  const SectionsPettyCash({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: AppColors.secondaryGradient,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 3))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(AssetIcons.walletSolid, width: 32, height: 32, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
              const SizedBox(width: 12),
              Text('Petty Cash', style: AppTextStyles.heading5Bold.copyWith(color: Colors.white)),
            ],
          ),
          Text(CurrencyFormat.toRupiah(0), style: AppTextStyles.heading5Bold.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
