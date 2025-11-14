import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionProvider extends ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  late StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectionProvider() {
    _init();
  }

  void _init() async {
    await _checkConnection();
    _listenConnection();
  }

  Future<void> _checkConnection() async {
    final results = await Connectivity().checkConnectivity();
    final connected = results.isNotEmpty && results.first != ConnectivityResult.none;
    _isConnected = connected;
    notifyListeners();
  }

  void _listenConnection() {
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      final connected = results.isNotEmpty && results.first != ConnectivityResult.none;
      if (connected != _isConnected) {
        _isConnected = connected;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
