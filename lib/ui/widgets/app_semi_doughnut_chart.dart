import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';

class AppSemiDoughnutChart extends StatefulWidget {
  final double value;
  final int valueLeft;
  final int valueRight;
  final String label;
  final String number;
  final List<Color>? gradientColors;

  const AppSemiDoughnutChart({
    super.key,
    required this.value,
    required this.label,
    required this.number,
    this.gradientColors,
    required this.valueLeft,
    required this.valueRight,
  });

  @override
  State<AppSemiDoughnutChart> createState() => _AppSemiDoughnutChartState();
}

class _AppSemiDoughnutChartState extends State<AppSemiDoughnutChart> {
  @override
  Widget build(BuildContext context) {
    final double remaining = 100;
    final l = AppLocalizations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            spacing: 6,
            children: [
              Container(height: 8, width: 8, color: AppColors.sky950),
              Text(l?.home_visited ?? '', style: AppTextStyles.caption2Regular),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            spacing: 6,
            children: [
              Container(height: 8, width: 8, color: AppColors.neutral600),
              Text(l?.home_notVisited ?? '', style: AppTextStyles.caption2Regular),
            ],
          ),
        ),
        Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: widget.value > 100 ? 100 : widget.value),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInToLinear,
            builder: (context, animatedValue, _) {
              return SizedBox(
                width: 232,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.5,
                        child: SizedBox(
                          height: 280,
                          child: PieChart(
                            PieChartData(
                              startDegreeOffset: 180,
                              centerSpaceRadius: 55,
                              sectionsSpace: 0,
                              sections: [
                                PieChartSectionData(
                                  value: animatedValue,
                                  showTitle: false,
                                  radius: 60,
                                  gradient: LinearGradient(
                                    colors: widget.gradientColors ?? const [Color(0xFF38BDF8), Color(0xFF082F49)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                PieChartSectionData(value: remaining, showTitle: false, radius: 60, color: AppColors.neutral500),
                              ],
                            ),
                            swapAnimationDuration: const Duration(milliseconds: 300),
                            swapAnimationCurve: Curves.linearToEaseOut,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Column(
                        children: [
                          Text(widget.number, style: AppTextStyles.heading6Bold),
                          const SizedBox(height: 2),
                          Text(widget.label, style: AppTextStyles.body4Medium.copyWith(color: Colors.black)),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 28,
                      child: Text(widget.valueLeft.toString(), style: AppTextStyles.label2Bold.copyWith(color: AppColors.white)),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 28,
                      child: Text(widget.valueRight.toString(), style: AppTextStyles.label2Bold.copyWith(color: AppColors.white)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
