import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<List<ConnectivityResult>>
  _connectivityStreamController =
      StreamController<List<ConnectivityResult>>.broadcast();

  /// Stream untuk mendengarkan perubahan koneksi
  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivityStreamController.stream;

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      _connectivityStreamController.add(results);
    });
  }

  /// Mengecek status koneksi saat ini (Wi-Fi, Mobile, None)
  Future<List<ConnectivityResult>> checkConnectivity() async {
    return await _connectivity.checkConnectivity();
  }

  /// Mengecek apakah sedang terhubung ke jaringan apa pun
  Future<bool> get isConnected async {
    final results = await checkConnectivity();
    return results.isNotEmpty &&
        results.any((r) => r != ConnectivityResult.none);
  }

  void dispose() {
    _connectivityStreamController.close();
  }
}
