import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';

enum AppButtonType { primary, warning, danger, sky950, sky50 }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final AppButtonType type;
  final double? width;
  final double height;
  final IconData? icon;
  final bool isFullWidth;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.width,
    this.height = 36,
    this.icon,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor = Colors.white;

    switch (type) {
      case AppButtonType.primary:
        backgroundColor = AppColors.sky700;
        break;
      case AppButtonType.warning:
        backgroundColor = AppColors.warning;
        break;
      case AppButtonType.danger:
        backgroundColor = AppColors.error;
        break;
      case AppButtonType.sky950:
        backgroundColor = AppColors.sky950;
        break;
      case AppButtonType.sky50:
        backgroundColor = AppColors.sky50;
        break;
    }

    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 18, color: textColor), const SizedBox(width: 6)],
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: type == AppButtonType.sky50 ? AppColors.textPrimary : Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
