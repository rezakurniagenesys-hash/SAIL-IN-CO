import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sail_in_co/core/constants/asset_images.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();
  static Completer<void>? _permissionRequestCompleter;

  /// Ambil gambar dari galeri
  static Future<File?> pickFromGallery(BuildContext context) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
      _showError(context, 'Gagal mengambil gambar dari galeri.');
    }
    return null;
  }

  /// Ambil gambar langsung dari kamera (langsung arahkan ke dialog setting jika belum izin)
  static Future<File?> pickFromCamera(BuildContext context) async {
    try {
      // Jika ada request permission yang sedang berjalan, tunggu selesai.
      if (_permissionRequestCompleter != null && !_permissionRequestCompleter!.isCompleted) {
        await _permissionRequestCompleter!.future;
      }

      _permissionRequestCompleter ??= Completer<void>();

      final status = await Permission.camera.status;

      // Jika izin kamera sudah diberikan → langsung buka kamera
      if (status.isGranted) {
        _completePermissionCompleter();
        final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
        return pickedFile != null ? File(pickedFile.path) : null;
      }

      // Jika izin belum diberikan → langsung munculkan bottomsheet (tanpa request ulang)
      _completePermissionCompleter();
      await _showCameraPermissionBottomSheet(context, status.isPermanentlyDenied);
    } catch (e) {
      debugPrint('Error picking image from camera: $e');
      _completePermissionCompleter();
      _showError(context, 'Gagal membuka kamera.');
    }

    return null;
  }

  /// Tampilkan pilihan kamera / galeri
  static Future<File?> pickImageDialog(BuildContext context) async {
    return showModalBottomSheet<File?>(
      context: context,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil dari Kamera'),
              onTap: () async {
                Navigator.pop(ctx, await pickFromCamera(context));
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Pilih dari Galeri'),
              onTap: () async {
                Navigator.pop(ctx, await pickFromGallery(context));
              },
            ),
          ],
        ),
      ),
    );
  }

  // helper untuk menyelesaikan dan reset completer
  static void _completePermissionCompleter() {
    try {
      if (_permissionRequestCompleter != null && !_permissionRequestCompleter!.isCompleted) {
        _permissionRequestCompleter!.complete();
      }
    } catch (_) {}
    _permissionRequestCompleter = null;
  }

  /// BottomSheet kustom yang menjelaskan kenapa permission diperlukan
  static Future<void> _showCameraPermissionBottomSheet(BuildContext context, bool permanentlyDenied) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      // tampilan yang lebih modern
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 24 + MediaQuery.of(ctx).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Center(child: Image.asset(AssetImages.permissionCamera, height: 52)),
              SizedBox(height: 12),
              Center(
                child: Text('Izinkan akses kamera untuk mengambil foto', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              ),
              SizedBox(height: 16),
              AppButton(
                label: 'Aktifkan Kamera',
                isFullWidth: true,
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  await openAppSettings();
                },
              ),
              SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  static void _showError(BuildContext context, String message) {
    // Anda bisa ganti menjadi SnackBar/Toast sesuai style aplikasi
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
