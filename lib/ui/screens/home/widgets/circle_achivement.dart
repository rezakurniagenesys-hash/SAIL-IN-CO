import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class CircleAchivement extends StatelessWidget {
  const CircleAchivement({super.key, required this.title, required this.count});
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    String formatTitle(String text) {
      final parts = text.split(" ");
      if (parts.length <= 1) return text;

      final lastWord = parts.removeLast();
      return "${parts.join(" ")}\n$lastWord";
    }

    return Column(
      spacing: 8,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            border: Border.all(color: AppColors.sky100, width: 1.5),
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(color: AppColors.sky100, shape: BoxShape.circle),
              ),
              Text('$count', style: AppTextStyles.heading3Medium.copyWith(color: AppColors.sky950)),
            ],
          ),
        ),
        Text(
          formatTitle(title),
          textAlign: TextAlign.center,
          style: AppTextStyles.body4Reguler.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}
