import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionUtils {
  /// Cek koneksi sekarang (true = online)
  static Future<bool> isConnected() async {
    final results = await Connectivity().checkConnectivity();
    return results.isNotEmpty && results.first != ConnectivityResult.none;
  }

  /// Stream koneksi (true/false)
  static Stream<bool> get connectionStream async* {
    // Emit nilai awal
    yield await isConnected();

    // Emit perubahan koneksi
    yield* Connectivity().onConnectivityChanged.map((results) {
      return results.isNotEmpty && results.first != ConnectivityResult.none;
    });
  }
}
