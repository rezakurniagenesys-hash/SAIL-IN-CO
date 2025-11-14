import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'connectivity_service.dart';

class NetworkChecker {
  final ConnectivityService _connectivityService;

  NetworkChecker(this._connectivityService);

  /// Mengecek apakah perangkat benar-benar memiliki akses internet (ping ke google.com)
  Future<bool> get hasInternet async {
    final results = await _connectivityService.checkConnectivity();
    if (results.isEmpty || !results.any((r) => r != ConnectivityResult.none)) {
      return false;
    }

    try {
      final lookup = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 3));
      return lookup.isNotEmpty && lookup.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    } on Exception {
      return false;
    }
  }
}

// Cara Pakai
final connectivityService = ConnectivityService();
final networkChecker = NetworkChecker(connectivityService);

Future<void> checkConnection() async {
  final isConnected = await networkChecker.hasInternet;
  // ignore: avoid_print
  print(isConnected ? '✅ Online' : '❌ Offline');
}
