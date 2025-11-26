import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';

class AppScan extends StatefulWidget {
  const AppScan({super.key});

  @override
  State<AppScan> createState() => _AppScanState();
}

class _AppScanState extends State<AppScan> {
  final MobileScannerController controller = MobileScannerController();
  bool isProcessing = false;

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (isProcessing) return;

    final code = barcodes.barcodes.firstOrNull;
    if (code == null) return;

    isProcessing = true;

    // Stop kamera dulu biar tidak double detect
    await controller.stop();

    if (mounted) {
      Navigator.pop(context, code.rawValue ?? "");
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: 'Scan Customer Barcode'),
      backgroundColor: Colors.black,
      body: MobileScanner(controller: controller, onDetect: _handleBarcode),
    );
  }
}
