import 'package:flutter/material.dart';
import 'dart:math';

import 'package:sail_in_co/core/theme/app_color.dart';

class AppCustomLoadingSpinner extends StatefulWidget {
  final double size;
  final Color color;

  const AppCustomLoadingSpinner({super.key, this.size = 40, this.color = AppColors.sky950});

  @override
  State<AppCustomLoadingSpinner> createState() => _AppCustomLoadingSpinnerState();
}

class _AppCustomLoadingSpinnerState extends State<AppCustomLoadingSpinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(angle: _controller.value * 2 * pi, child: child);
        },
        child: CustomPaint(painter: _SpinnerPainter(widget.color)),
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  final Color color;
  _SpinnerPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < 8; i++) {
      final double angle = (pi / 4) * i;

      final Offset start = Offset(center.dx + (radius - 10) * cos(angle), center.dy + (radius - 10) * sin(angle));

      final Offset end = Offset(center.dx + radius * cos(angle), center.dy + radius * sin(angle));

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
