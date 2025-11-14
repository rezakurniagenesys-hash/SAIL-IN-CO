import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class SummaryRow extends StatelessWidget {
  final Map<String, String> data;
  final double spacing;
  final double labelValueSpacing;

  const SummaryRow({
    super.key,
    required this.data,
    this.spacing = 6,
    this.labelValueSpacing = 48, // sama dengan 12 * 4
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Kolom Label
        Expanded(
          child: Column(
            spacing: spacing,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: data.keys.map((label) {
              return Text('$label :', style: AppTextStyles.body3Medium.copyWith(color: AppColors.textPrimary));
            }).toList(),
          ),
        ),

        SizedBox(width: labelValueSpacing),

        // 🔹 Kolom Nilai
        Column(
          spacing: spacing,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: data.values.map((value) {
            return Text(value, style: AppTextStyles.body3Medium.copyWith(color: AppColors.textPrimary));
          }).toList(),
        ),
      ],
    );
  }
}
