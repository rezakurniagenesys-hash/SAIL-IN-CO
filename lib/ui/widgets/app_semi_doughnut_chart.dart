import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class AppSemiDoughnutChart extends StatefulWidget {
  final double value;
  final String label;
  final String title;
  final String number;
  final List<Color>? gradientColors;

  const AppSemiDoughnutChart({super.key, required this.value, required this.label, required this.title, required this.number, this.gradientColors});

  @override
  State<AppSemiDoughnutChart> createState() => _AppSemiDoughnutChartState();
}

class _AppSemiDoughnutChartState extends State<AppSemiDoughnutChart> {
  @override
  Widget build(BuildContext context) {
    final double remaining = 100;

    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: widget.value > 100 ? 100 : widget.value),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInToLinear,
        builder: (context, animatedValue, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.5,
                  child: SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        startDegreeOffset: 180,
                        centerSpaceRadius: 40,
                        sectionsSpace: 0,
                        sections: [
                          PieChartSectionData(
                            value: animatedValue,
                            showTitle: false,
                            radius: 50,
                            gradient: LinearGradient(
                              colors: widget.gradientColors ?? const [Color(0xFF38BDF8), Color(0xFF082F49)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          PieChartSectionData(value: remaining, showTitle: false, radius: 50, color: Colors.grey.shade300),
                        ],
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 300),
                      swapAnimationCurve: Curves.linearToEaseOut,
                    ),
                  ),
                ),
              ),
              Positioned(top: 10, child: Text(widget.title, style: AppTextStyles.heading6Bold)),
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
            ],
          );
        },
      ),
    );
  }
}
