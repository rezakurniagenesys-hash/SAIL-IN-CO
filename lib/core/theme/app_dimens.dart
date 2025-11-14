import 'package:flutter/material.dart';

class AppDimens {
  // Padding
  static const double padding2 = 2.0;
  static const double padding4 = 4.0;
  static const double padding8 = 8.0;
  static const double padding12 = 12.0;
  static const double padding16 = 16.0;
  static const double padding20 = 20.0;
  static const double padding24 = 24.0;
  static const double padding32 = 32.0;

  // Margin
  static const double margin4 = 4.0;
  static const double margin8 = 8.0;
  static const double margin12 = 12.0;
  static const double margin16 = 16.0;
  static const double margin20 = 20.0;
  static const double margin24 = 24.0;

  // Radius untuk elemen lembut (Confessly punya gaya rounded & calm)
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 16.0;
  static const double radiusLarge = 24.0;
  static const double radiusXLarge = 32.0;

  // Ukuran ikon
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;

  // Ukuran tombol
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeight = 48.0;
  static const double buttonHeightLarge = 56.0;

  // Ukuran teks (opsional, bisa juga di app_typography.dart)
  static const double textSmall = 12.0;
  static const double textNormal = 14.0;
  static const double textLarge = 18.0;
  static const double textXLarge = 22.0;

  // 🩵 Spacing antar elemen (misal antar card atau antar section)
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;

  // 📱 Padding layar (misal untuk body Scaffold)
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 16,
  );

  // 🔲 Border radius reusable
  static const BorderRadius borderRadiusSmall = BorderRadius.all(
    Radius.circular(radiusSmall),
  );
  static const BorderRadius borderRadiusMedium = BorderRadius.all(
    Radius.circular(radiusMedium),
  );
  static const BorderRadius borderRadiusLarge = BorderRadius.all(
    Radius.circular(radiusLarge),
  );
}
