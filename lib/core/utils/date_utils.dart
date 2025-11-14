import 'package:intl/intl.dart';

class DateUtilsHelper {
  DateUtilsHelper._(); // private constructor

  /// Format DateTime ke string dengan pattern tertentu (default: dd MMM yyyy)
  static String formatDate(DateTime? date, {String pattern = 'dd MMM yyyy'}) {
    if (date == null) return '-';
    return DateFormat(pattern).format(date);
  }

  /// Format waktu (contoh: 14:30)
  static String formatTime(DateTime? date, {String pattern = 'HH:mm'}) {
    if (date == null) return '-';
    return DateFormat(pattern).format(date);
  }

  /// Parse string ke DateTime dengan pattern tertentu
  static DateTime? parseDate(String? dateString, {String pattern = 'dd-MM-yyyy'}) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return DateFormat(pattern).parse(dateString);
    } catch (_) {
      return null;
    }
  }

  /// Menghitung selisih hari
  static int daysBetween(DateTime from, DateTime to) {
    return to.difference(from).inDays;
  }

  /// Mengecek apakah tanggal hari ini
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year && now.month == date.month && now.day == date.day;
  }

  /// Format human readable: "2 jam lalu", "Kemarin", dll
  static String timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inSeconds < 60) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    if (diff.inDays == 1) return 'Kemarin';
    if (diff.inDays < 30) return '${diff.inDays} hari lalu';
    return DateFormat('dd MMM yyyy').format(dateTime);
  }
}
