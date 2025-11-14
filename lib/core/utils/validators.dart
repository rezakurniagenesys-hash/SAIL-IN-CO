class Validators {
  Validators._();

  static String? required(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName wajib diisi';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email wajib diisi';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Format email tidak valid';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Nomor telepon wajib diisi';
    final regex = RegExp(r'^[0-9]{9,15}$');
    if (!regex.hasMatch(value)) return 'Nomor telepon tidak valid';
    return null;
  }

  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) return 'Password wajib diisi';
    if (value.length < minLength) return 'Minimal $minLength karakter';
    return null;
  }

  static String? confirmPassword(String? value, String? original) {
    if (value != original) return 'Konfirmasi password tidak cocok';
    return null;
  }

  static String? number(String? value) {
    if (value == null || value.isEmpty) return 'Angka wajib diisi';
    if (double.tryParse(value) == null) return 'Harus berupa angka';
    return null;
  }
}
