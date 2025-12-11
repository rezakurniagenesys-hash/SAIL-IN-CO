// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:detect_fake_location/detect_fake_location.dart';
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

      if (latitude == 0 && longitude == 0) {
        debugPrint('Coordinates are (0,0) — skipping reverse geocoding.');
        return null;
      }

      final List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) return null;

      final p = placemarks.first;

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
      return null;
    }
  }

  /// Public: minta posisi saat ini. Kembalikan null jika gagal / tidak diizinkan atau fake.
  static Future<Position?> getCurrentPositionWithPermissionFlow(
    BuildContext context, {
    LocationAccuracy accuracy = LocationAccuracy.best,
    Duration settingsTimeout = const Duration(seconds: 30),
  }) async {
    try {
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

      // Cek permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        final permanentlyDenied = permission == LocationPermission.deniedForever;
        _completePermissionCompleter();
        final openedSettings = await _showLocationPermissionBottomSheet(context, permanentlyDenied);
        if (!openedSettings) return null;

        final granted = await _waitForPermissionAfterReturning(context, timeout: settingsTimeout);
        if (!granted) return null;
      }

      _completePermissionCompleter();

      // Ambil posisi
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: accuracy);

      // Cek fake location
      final isFake = await DetectFakeLocation().detectFakeLocation();
      if (isFake) {
        await _showFakeGpsWarning(context);
        return null;
      }

      return pos;
    } catch (e, st) {
      debugPrint('LocationHelper error: $e\n$st');
      _completePermissionCompleter();
      return null;
    }
  }

  static void _completePermissionCompleter() {
    try {
      if (_permissionCompleter != null && !_permissionCompleter!.isCompleted) {
        _permissionCompleter!.complete();
      }
    } catch (_) {}
    _permissionCompleter = null;
  }

  static Future<void> _showEnableLocationServiceDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Aktifkan GPS'),
        content: Text('GPS belum aktif. Silahkan aktifkan dulu untuk mendapatkan lokasi.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Batal')),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await openAppSettings();
            },
            child: Text('Buka Pengaturan'),
          ),
        ],
      ),
    );
  }

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

  static Future<bool> _waitForPermissionAfterReturning(BuildContext context, {Duration timeout = const Duration(seconds: 30)}) async {
    final completer = Completer<void>();
    late _LifecycleListener listener;

    listener = _LifecycleListener(
      onResume: () {
        if (!completer.isCompleted) completer.complete();
      },
    );

    WidgetsBinding.instance.addObserver(listener);

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

    await Future.any([completer.future, Future.delayed(timeout)]);

    try {
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();
    } catch (_) {}

    WidgetsBinding.instance.removeObserver(listener);

    final LocationPermission newPermission = await Geolocator.checkPermission();
    return (newPermission == LocationPermission.whileInUse || newPermission == LocationPermission.always);
  }

  static Future<void> _showFakeGpsWarning(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Peringatan Fake GPS!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Text(
                'Aplikasi mendeteksi penggunaan fake GPS. Mohon matikan aplikasi mock location untuk melanjutkan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 20),
              AppButton(
                label: 'Tutup',
                isFullWidth: true,
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LifecycleListener extends WidgetsBindingObserver {
  final VoidCallback onResume;
  _LifecycleListener({required this.onResume});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) onResume();
  }
}
