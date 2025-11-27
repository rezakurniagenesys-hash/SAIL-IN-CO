import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';

class AppSemiDoughnutChart extends StatefulWidget {
  final int completed; // completed_tasks
  final int pending; // pending_tasks
  final int total; // total_tasks
  final String label;
  final List<Color>? gradientColors;

  /// NEW: loading flag
  final bool isLoading;

  const AppSemiDoughnutChart({
    super.key,
    required this.completed,
    required this.pending,
    required this.total,
    required this.label,
    this.gradientColors,
    this.isLoading = false,
  });

  @override
  State<AppSemiDoughnutChart> createState() => _AppSemiDoughnutChartState();
}

class _AppSemiDoughnutChartState extends State<AppSemiDoughnutChart> with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Widget _buildShimmerSemiDoughnut({required double size, required double holeRadius}) {
    // size = width 232 from original
    // outer circle radius visually ~60 (we used radius:60 for sections); tune accordingly
    return SizedBox(
      width: size,
      child: Center(
        child: AnimatedBuilder(
          animation: _shimmerController,
          builder: (context, _) {
            // animate alignment positions for gradient to create shimmer slide
            final t = _shimmerController.value; // 0..1
            // move gradient from left to right
            final begin = Alignment(-1.5 + 3.0 * t, -0.3);
            final end = Alignment(-0.5 + 3.0 * t, 0.3);

            // gradient colors for shimmer (soft)
            final gColors = [AppColors.neutral300.withOpacity(0.15), AppColors.neutral400.withOpacity(0.05), AppColors.neutral500.withOpacity(0.15)];

            // Outer circle with animated gradient
            final outer = Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(begin: begin, end: end, colors: gColors, stops: const [0.0, 0.5, 1.0]),
              ),
            );

            // inner circle "hole"
            final inner = Container(
              width: holeRadius * 2,
              height: holeRadius * 2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0), // transparent hole so background shows through
                // To create the donut hole effect we will use BoxDecoration with blend by placing on top,
                // but we also want a visible gap; so we use same background color as parent center if needed.
              ),
            );

            // To produce donut effect we overlay inner as solid color matching canvas background.
            // We'll make the hole slightly elevated with same color as parent background (assumes white).
            // If your UI background differs, adjust color accordingly or pass it as parameter.
            final holeColor = Colors.white; // default inner background color used by surrounding card

            final innerColored = Container(
              width: holeRadius * 2,
              height: holeRadius * 2,
              decoration: BoxDecoration(color: holeColor, shape: BoxShape.circle),
            );

            return Stack(
              alignment: Alignment.center,
              children: [
                // Clip only top half (semi doughnut)
                ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.5,
                    child: SizedBox(
                      width: size,
                      height: size,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          outer,
                          // place inner colored circle to form hole
                          innerColored,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    final total = widget.total <= 0 ? 0 : widget.total;
    final completedClamped = (widget.completed < 0) ? 0 : (widget.completed > total ? total : widget.completed);

    // size constants (same as previous widget)
    const chartWidth = 232.0;
    const outerRadius = 60.0; // used by PieChart sections radius earlier
    const centerSpaceRadius = 55.0; // same as centerSpaceRadius
    // compute hole radius visually similar to centerSpaceRadius
    final holeRadius = centerSpaceRadius; // in pixels; we use this for shimmer inner circle

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(height: 8, width: 8, color: AppColors.sky950),
              const SizedBox(width: 6),
              Text(l?.home_visited ?? '', style: AppTextStyles.caption2Regular),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(height: 8, width: 8, color: AppColors.neutral600),
              const SizedBox(width: 6),
              Text(l?.home_notVisited ?? '', style: AppTextStyles.caption2Regular),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: TweenAnimationBuilder<double>(
            // animate dari 0 hingga completedClamped (angka)
            tween: Tween(begin: 0.0, end: completedClamped.toDouble()),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            builder: (context, animatedCompletedValue, _) {
              // animatedCompletedValue: angka (0..completedClamped)
              final animatedCompleted = animatedCompletedValue.clamp(0.0, completedClamped.toDouble());
              final animatedPending = (total - animatedCompleted).clamp(0.0, total.toDouble());

              // Filler yang membuat total chart menjadi 2 * total sehingga
              // completed+pending akan mengambil setengah lingkaran.
              final fillerValue = total.toDouble();

              // Jika total == 0, berikan fallback supaya chart tidak crash
              final sectionCompletedValue = total > 0 ? animatedCompleted : 0.0;
              final sectionPendingValue = total > 0 ? animatedPending : 0.0;
              final sectionFillerValue = total > 0 ? fillerValue : 1.0; // kalau 0, beri 1 agar pie tetap render

              // If loading -> show shimmer instead of real piechart
              if (widget.isLoading) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: chartWidth,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // shimmer semicircle donut
                        _buildShimmerSemiDoughnut(size: chartWidth, holeRadius: holeRadius),
                        // center total + label (could show placeholder)
                        Positioned(
                          bottom: 0,
                          child: Column(
                            children: [
                              // show shimmered placeholder for number (grey box)
                              Container(width: 36, height: 20, color: AppColors.neutral300.withOpacity(0.4)),
                              const SizedBox(height: 6),
                              Container(width: 60, height: 12, color: AppColors.neutral300.withOpacity(0.35)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Normal chart rendering
              return SizedBox(
                width: chartWidth,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Clip hanya top half
                    ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.5,
                        child: SizedBox(
                          height: 280,
                          child: PieChart(
                            PieChartData(
                              startDegreeOffset: 180, // supaya semi berada di atas
                              centerSpaceRadius: centerSpaceRadius,
                              sectionsSpace: 0,
                              pieTouchData: PieTouchData(enabled: false),
                              sections: [
                                // Section Completed
                                PieChartSectionData(
                                  value: sectionCompletedValue,
                                  showTitle: false,
                                  radius: outerRadius,
                                  gradient: LinearGradient(
                                    colors: widget.gradientColors ?? const [Color(0xFF38BDF8), Color(0xFF082F49)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                // Section Pending (sisa)
                                PieChartSectionData(value: sectionPendingValue, showTitle: false, radius: outerRadius, color: AppColors.neutral500),
                                // Filler (transparent) -> membuat completed+pending hanya mengisi setengah lingkaran
                                PieChartSectionData(
                                  value: sectionFillerValue,
                                  showTitle: false,
                                  radius: outerRadius,
                                  color: Colors.transparent,
                                  borderSide: BorderSide.none,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // TOTAL NUMBER + LABEL
                    Positioned(
                      bottom: 0,
                      child: Column(
                        children: [
                          Text(widget.total.toString(), style: AppTextStyles.heading6Bold),
                          const SizedBox(height: 2),
                          Text(widget.label, style: AppTextStyles.body4Medium.copyWith(color: Colors.black)),
                        ],
                      ),
                    ),

                    // COMPLETED LABEL (left)
                    Positioned(
                      bottom: 10,
                      left: 28,
                      child: Text(widget.completed.toString(), style: AppTextStyles.label2Bold.copyWith(color: AppColors.white)),
                    ),

                    // PENDING LABEL (right)
                    Positioned(
                      bottom: 10,
                      right: 28,
                      child: Text(widget.pending.toString(), style: AppTextStyles.label2Bold.copyWith(color: AppColors.white)),
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
