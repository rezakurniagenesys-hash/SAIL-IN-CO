import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class AppPdfGenerator {
  static Future<File> generate(ReceiptData data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: const pw.EdgeInsets.all(10),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              /// LOGO + HEADER
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text('ARTA JAYA ABADI', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 4),
                    pw.Text('Jl. Surabaya Indah No.33-C\nPucang Anom, Kota Surabaya', textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 8)),
                  ],
                ),
              ),

              pw.Divider(),

              _row('No', data.no),
              _row('Tanggal', data.tanggal),
              _row('Pelanggan', data.pelanggan),
              _row('Tipe', data.tipe),
              _row('Catatan', data.catatan),

              pw.Divider(),

              /// ITEMS
              ...data.items.map((e) {
                final total = e.qty * e.price;
                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(child: pw.Text('${e.qty} ${e.name}', style: const pw.TextStyle(fontSize: 9))),
                    pw.Text(_currency(total), style: const pw.TextStyle(fontSize: 9)),
                  ],
                );
              }),

              pw.Divider(),

              _row('Order Fee', _currency(data.orderFee)),

              pw.SizedBox(height: 6),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Grand Total', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                  pw.Text(_currency(_grandTotal(data)), style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                ],
              ),

              pw.SizedBox(height: 12),

              pw.Center(child: pw.Text('Terima Kasih', style: const pw.TextStyle(fontSize: 9))),
            ],
          );
        },
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/receipt.pdf');
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  static int _grandTotal(ReceiptData data) {
    final itemsTotal = data.items.fold<int>(0, (sum, item) => sum + (item.qty * item.price));
    return itemsTotal + data.orderFee;
  }

  static pw.Widget _row(String label, String value) {
    return pw.Row(
      children: [
        pw.SizedBox(width: 70, child: pw.Text(label, style: const pw.TextStyle(fontSize: 8))),
        pw.Text(': ', style: const pw.TextStyle(fontSize: 8)),
        pw.Expanded(child: pw.Text(value, style: const pw.TextStyle(fontSize: 8))),
      ],
    );
  }

  static String _currency(int value) {
    return value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.');
  }
}

class ReceiptItem {
  final String name;
  final int qty;
  final int price;

  ReceiptItem({required this.name, required this.qty, required this.price});
}

class ReceiptData {
  final String no;
  final String tanggal;
  final String pelanggan;
  final String tipe;
  final String catatan;
  final List<ReceiptItem> items;
  final int orderFee;

  ReceiptData({
    required this.no,
    required this.tanggal,
    required this.pelanggan,
    required this.tipe,
    required this.catatan,
    required this.items,
    required this.orderFee,
  });
}
