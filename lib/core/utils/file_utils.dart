import 'dart:io';
import 'dart:math' as math;
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class FileUtils {
  FileUtils._();

  /// Simpan file ke direktori sementara
  static Future<File> saveTempFile(String fileName, List<int> bytes) async {
    final dir = await getTemporaryDirectory();
    final file = File(path.join(dir.path, fileName));
    return file.writeAsBytes(bytes, flush: true);
  }

  /// Hapus file
  static Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Mendapatkan ukuran file dalam format human readable (KB, MB, GB)
  static String getFileSize(File file) {
    final bytes = file.lengthSync();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    final i = (math.log(bytes) / math.log(1024)).floor();
    final size = (bytes / math.pow(1024, i)).toStringAsFixed(2);
    return "$size ${suffixes[i]}";
  }

  /// Mengecek apakah file ada
  static Future<bool> fileExists(String filePath) async {
    return await File(filePath).exists();
  }

  /// Dapatkan nama file dari path lengkap
  static String getFileName(String filePath) {
    return path.basename(filePath);
  }

  /// Dapatkan ekstensi file (tanpa titik)
  static String getFileExtension(String filePath) {
    return path.extension(filePath).replaceAll('.', '');
  }

  /// Membuat direktori sementara baru
  static Future<Directory> createTempDir(String dirName) async {
    final tempDir = await getTemporaryDirectory();
    final newDir = Directory(path.join(tempDir.path, dirName));
    if (!(await newDir.exists())) {
      await newDir.create(recursive: true);
    }
    return newDir;
  }
}
