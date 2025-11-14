import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ImageUtils {
  ImageUtils._();

  /// Ambil gambar dari galeri atau kamera
  static Future<File?> pickImage({
    ImageSource source = ImageSource.gallery,
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  /// Ubah ukuran gambar sebelum upload
  static Future<Uint8List?> resizeImage(File file, {int width = 800}) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return null;
    final resized = img.copyResize(image, width: width);
    return Uint8List.fromList(img.encodeJpg(resized, quality: 85));
  }

  /// Load gambar dari assets sebagai bytes
  static Future<Uint8List> loadAssetAsBytes(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }

  /// Validasi ekstensi file gambar
  static bool isImageFile(String path) {
    final ext = path.toLowerCase();
    return ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.png') ||
        ext.endsWith('.webp');
  }
}
