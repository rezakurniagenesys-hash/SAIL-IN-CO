import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';


class DevelopmentScan extends StatefulWidget {
  const DevelopmentScan({super.key});

  @override
  State<DevelopmentScan> createState() => _DevelopmentScanState();
}

class _DevelopmentScanState extends State<DevelopmentScan> {
  Barcode? barcode;

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        barcode = barcodes.barcodes.firstOrNull;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: 'Scan Customer Barcode'),
      backgroundColor: Colors.black,
      body: Stack(children: [MobileScanner(onDetect: _handleBarcode)]),
    );
  }
}
