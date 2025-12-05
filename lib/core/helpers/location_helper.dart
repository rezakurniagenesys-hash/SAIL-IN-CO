// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sail_in_co/core/constants/asset_images.dart';
import 'package:sail_in_co/ui/widgets/app_button.dart';

class LocationHelper {
  // lock untuk mencegah multiple permission requests
  static Completer<void>? _permissionCompleter;

  static Future<String?> latLongToAddress(double latitude, double longitude) async {
    try {
      debugPrint('Reverse geocoding for: $latitude, $longitude');

      // quick guard: coordinates valid?
      if (latitude == 0 && longitude == 0) {
        debugPrint('Coordinates are (0,0) — skipping reverse geocoding.');
        return null;
      }

      final List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      debugPrint('placemarks length: ${placemarks.length}');
      if (placemarks.isEmpty) {
        debugPrint('No placemarks returned.');
        return null;
      }

      final p = placemarks.first;
      debugPrint(
        'Placemark fields -> street:${p.street}, subLocality:${p.subLocality}, locality:${p.locality}, subAdmin:${p.subAdministrativeArea}, admin:${p.administrativeArea}, postal:${p.postalCode}',
      );

      // Build a human-friendly address, skipping null/empty parts
      final parts = <String>[];
      if ((p.street ?? '').isNotEmpty) parts.add(p.street!);
      if ((p.subLocality ?? '').isNotEmpty) parts.add(p.subLocality!);
      if ((p.locality ?? '').isNotEmpty) parts.add(p.locality!);
      if ((p.subAdministrativeArea ?? '').isNotEmpty) parts.add(p.subAdministrativeArea!);
      if ((p.administrativeArea ?? '').isNotEmpty) parts.add(p.administrativeArea!);
      if ((p.postalCode ?? '').isNotEmpty) parts.add(p.postalCode!);

      final address = parts.join(', ');
      return address.isNotEmpty ? address : null;
    } catch (e, st) {
      debugPrint('Error reverse geocoding: $e\n$st');
      // Bisa kembalikan null atau pesan default
      return null;
    }
  }

  /// Public: minta posisi saat ini. Kembalikan null jika gagal / tidak diizinkan.
  static Future<Position?> getCurrentPositionWithPermissionFlow(
    BuildContext context, {
    LocationAccuracy accuracy = LocationAccuracy.best,
    Duration settingsTimeout = const Duration(seconds: 30),
  }) async {
    try {
      // Jika ada request permission yang sedang berjalan, tunggu sampai selesai
      if (_permissionCompleter != null && !_permissionCompleter!.isCompleted) {
        await _permissionCompleter!.future;
      }

      _permissionCompleter ??= Completer<void>();

      // Pastikan GPS aktif
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await _showEnableLocationServiceDialog(context);

        if (!await Geolocator.isLocationServiceEnabled()) {
          _completePermissionCompleter();
          return null;
        }
      }

      // Cek status permission
      LocationPermission permission = await Geolocator.checkPermission();

      // Jika sudah granted → ambil posisi
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        _completePermissionCompleter();
        return await Geolocator.getCurrentPosition(desiredAccuracy: accuracy);
      }

      final bool permanentlyDenied = (permission == LocationPermission.deniedForever);

      // Lepaskan completer sebelum menampilkan bottomsheet
      _completePermissionCompleter();

      final openedSettings = await _showLocationPermissionBottomSheet(context, permanentlyDenied);

      if (!openedSettings) {
        // user menutup bottomsheet tanpa buka settings
        return null;
      }

      // User membuka settings → tunggu app kembali & cek permission
      final granted = await _waitForPermissionAfterReturning(context, timeout: settingsTimeout);

      if (granted) {
        return await Geolocator.getCurrentPosition(desiredAccuracy: accuracy);
      }

      return null;
    } catch (e, st) {
      debugPrint('LocationHelper error: $e\n$st');
      _completePermissionCompleter();
      return null;
    }
  }

  // helper untuk menyelesaikan dan reset completer
  static void _completePermissionCompleter() {
    try {
      if (_permissionCompleter != null && !_permissionCompleter!.isCompleted) {
        _permissionCompleter!.complete();
      }
    } catch (_) {}
    _permissionCompleter = null;
  }

  // Dialog singkat untuk minta user mengaktifkan Location Service (GPS)
  static Future<void> _showEnableLocationServiceDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Aktifkan Location Service'),
        content: Text('Location service (GPS) belum aktif. Silakan aktifkan untuk mendapatkan lokasi.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Batal')),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              // Membuka setting location service sistem tidak standar di semua device.
              // Kita bisa membuka App Settings sebagai alternatif:
              await openAppSettings();
            },
            child: Text('Buka Pengaturan'),
          ),
        ],
      ),
    );
  }

  // BottomSheet kustom yang menampilkan info izin lokasi; kembalikan true jika user memilih "Buka Pengaturan"
  static Future<bool> _showLocationPermissionBottomSheet(BuildContext context, bool permanentlyDenied) {
    return showModalBottomSheet<bool>(
      context: context,
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
                child: Text('Izinkan akses lokasi untuk validasi lokasi toko secara akurat', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              ),
              SizedBox(height: 16),
              AppButton(
                label: 'Aktifkan Lokasi',
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
    ).then((value) => value == true);
  }

  // Menunggu app resume lalu re-check permission; return true kalau granted
  static Future<bool> _waitForPermissionAfterReturning(BuildContext context, {Duration timeout = const Duration(seconds: 30)}) async {
    final completer = Completer<void>();
    late _LifecycleListener listener;

    listener = _LifecycleListener(
      onResume: () {
        if (!completer.isCompleted) completer.complete();
      },
    );

    WidgetsBinding.instance.addObserver(listener);

    // Tampilkan dialog kecil memberi tahu user kita menunggu (opsional)
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Menunggu Izin'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Silakan aktifkan izin lokasi pada Pengaturan, lalu kembali ke aplikasi.'),
              SizedBox(height: 12),
              Text('Menunggu selama ${timeout.inSeconds} detik...'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (!completer.isCompleted) completer.complete();
                Navigator.of(ctx).pop();
              },
              child: Text('Saya Kembali'),
            ),
          ],
        );
      },
    );

    // Tunggu resume atau timeout
    await Future.any([completer.future, Future.delayed(timeout)]);

    // Tutup dialog bila masih terbuka
    try {
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();
    } catch (_) {}

    WidgetsBinding.instance.removeObserver(listener);

    // Re-check permission
    final LocationPermission newPermission = await Geolocator.checkPermission();
    return (newPermission == LocationPermission.whileInUse || newPermission == LocationPermission.always);
  }
}

// Listener lifecycle kecil
class _LifecycleListener extends WidgetsBindingObserver {
  final VoidCallback onResume;
  _LifecycleListener({required this.onResume});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResume();
    }
  }
}
