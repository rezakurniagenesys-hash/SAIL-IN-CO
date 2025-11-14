import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';

class AppDraggableScrollableSheet extends StatelessWidget {
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final Widget Function(BuildContext context, ScrollController scrollController) builder;

  const AppDraggableScrollableSheet({super.key, required this.builder, this.initialChildSize = 0.5, this.minChildSize = 0.5, this.maxChildSize = 1.0});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6, offset: const Offset(0, -3))],
          ),
          child: Column(
            children: [
              // --- Handle bar ---
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: AppColors.neutral300, borderRadius: BorderRadius.circular(2)),
              ),
              // --- Custom Content Area ---
              Expanded(child: builder(context, scrollController)),
            ],
          ),
        );
      },
    );
  }
}
