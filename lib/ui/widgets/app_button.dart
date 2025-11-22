import 'package:auto_size_text/auto_size_text.dart';
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

  /// ➕ Tambahan
  final bool isLoading;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.width,
    this.height = 36,
    this.icon,
    this.isFullWidth = false,
    this.isLoading = false, // default false
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
        onPressed: isLoading ? null : onPressed, // ⛔ Disabled saat loading
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
            /// ⏳ Loader menggantikan isi
            if (isLoading)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(type == AppButtonType.sky50 ? AppColors.textPrimary : Colors.white),
                ),
              )
            else ...[
              if (icon != null) ...[Icon(icon, size: 18, color: textColor), const SizedBox(width: 6)],

              if (icon == null && isFullWidth)
                Expanded(
                  child: AutoSizeText(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: type == AppButtonType.sky50 ? AppColors.textPrimary : Colors.white),
                  ),
                )
              else
                Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: type == AppButtonType.sky50 ? AppColors.textPrimary : Colors.white),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
