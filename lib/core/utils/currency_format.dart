import 'package:intl/intl.dart';

class CurrencyFormat {
  static String toRupiah(dynamic amount, {bool withSymbol = true}) {
    if (amount == null) return withSymbol ? 'Rp 0' : '0';

    // Convert to double safely
    double value;
    try {
      value = double.parse(amount.toString());
    } catch (_) {
      return withSymbol ? 'Rp 0' : '0';
    }

    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: withSymbol ? 'Rp ' : '',
      decimalDigits: 0,
    );

    return formatter.format(value);
  }

  static String withDecimal(dynamic amount, {bool withSymbol = true}) {
    if (amount == null) return withSymbol ? 'Rp 0' : '0';

    double value;
    try {
      value = double.parse(amount.toString());
    } catch (_) {
      return withSymbol ? 'Rp 0' : '0';
    }

    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: withSymbol ? 'Rp ' : '',
      decimalDigits: 2,
    );

    return formatter.format(value);
  }
}
