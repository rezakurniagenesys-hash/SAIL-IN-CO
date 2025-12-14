import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReceiptPdfViewPage extends StatelessWidget {
  const ReceiptPdfViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Struk')),
      body: PdfPreview(
        canChangePageFormat: false,
        canChangeOrientation: false,
        allowPrinting: true,
        allowSharing: true,
        build: (PdfPageFormat format) async {
          return _buildDummyPdf();
        },
      ),
    );
  }

  /// PDF sementara (dummy)
  Future<Uint8List> _buildDummyPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: const pw.EdgeInsets.all(10),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Column(
                  children: [
                    // Logo placeholder - you can replace with actual logo
                    pw.Container(
                      width: 60,
                      height: 60,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.grey),
                        borderRadius: pw.BorderRadius.circular(4),
                      ),
                      child: pw.Center(
                        child: pw.Text('LOGO', style: pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      'ARTA JAYA ABADI',
                      style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text('PT. Artha Jaya Abadi Bersinar Surabaya', style: const pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
                    pw.Text('Jl. surabaya indah No.33-C Pucang Anom, Kota Surabaya.', style: const pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
                  ],
                ),
              ),

              pw.SizedBox(height: 8),

              pw.Divider(),

              _row('No', 'OS.0123123.1231322'),
              _row('Tanggal', '08-12-2025 10:45'),
              _row('Pelanggan', 'Genesys Indonesia'),
              _row('Tipe', 'ABC'),
              _row('Catatan', 'Lorem ipsum dolor sit amet'),

              pw.Divider(),

              _itemRow('1 Rokok ABC', '38.000'),
              _itemRow('1 Rokok ABC', '38.000'),

              pw.Divider(),

              _row('Order Fee', '3.500'),

              pw.SizedBox(height: 6),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Grand Total', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                  pw.Text('79.500', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                ],
              ),

              pw.SizedBox(height: 12),

              pw.Center(child: pw.Text('Terima Kasih', style: const pw.TextStyle(fontSize: 9))),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _row(String label, String value) {
    return pw.Row(
      children: [
        pw.SizedBox(width: 70, child: pw.Text(label, style: const pw.TextStyle(fontSize: 8))),
        pw.Text(': ', style: const pw.TextStyle(fontSize: 8)),
        pw.Expanded(child: pw.Text(value, style: const pw.TextStyle(fontSize: 8))),
      ],
    );
  }

  pw.Widget _itemRow(String name, String price) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(name, style: const pw.TextStyle(fontSize: 9)),
        pw.Text(price, style: const pw.TextStyle(fontSize: 9)),
      ],
    );
  }
}
