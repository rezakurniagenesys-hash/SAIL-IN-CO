// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:sail_in_co/core/utils/currency_format.dart';

import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/models/history/quick_sales_detail_response.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';
import 'package:sail_in_co/providers/sales/sales_provider.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';

class ReceiptPdfQuickSalesView extends StatefulWidget {
  const ReceiptPdfQuickSalesView({super.key, required this.quicSalesId});
  final String quicSalesId;

  @override
  State<ReceiptPdfQuickSalesView> createState() => _ReceiptPdfQuickSalesViewState();
}

class _ReceiptPdfQuickSalesViewState extends State<ReceiptPdfQuickSalesView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = context.read<SalesProvider>();
      provider.getQuickSalesOrder(quicSalesId: widget.quicSalesId, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: 'Print Struk Quick Sales'),
      body: Consumer<SalesProvider>(
        builder: (context, salesProvider, child) {
          if (salesProvider.isLoadingDetail) {
            return const Center(child: CircularProgressIndicator());
          } else if (salesProvider.quickSalesDetail == null) {
            return const Center(child: Text('Gagal memuat data sales order.'));
          } else {
            final quickSalesDetail = salesProvider.quickSalesDetail;
            return PdfPreview(
              canChangePageFormat: false,
              canChangeOrientation: false,
              allowPrinting: true,
              canDebug: false,
              allowSharing: true,
              build: (PdfPageFormat format) async {
                return _buildPdf(quickSalesDetail!, salesProvider, context);
              },
            );
          }
        },
      ),
    );
  }

  Future<Uint8List> _buildPdf(QuickSales data, SalesProvider salesProvider, BuildContext context) async {
    final fontData = await rootBundle.load('assets/fonts/lucidatypewriterregular.ttf');
    final l = AppLocalizations.of(context)!;
    final lucida = pw.Font.ttf(fontData);

    final pdf = pw.Document();

    final baseTextStyle = pw.TextStyle(font: lucida, fontSize: 8);
    final totalQty2 = data.details.fold<int>(0, (sum, item) => sum + int.parse(item.qty2));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: const pw.EdgeInsets.all(10),
        build: (context) {
          return pw.DefaultTextStyle(
            style: baseTextStyle,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Column(
                    children: [
                      pw.Container(
                        width: 100,
                        height: 100,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.grey),
                          borderRadius: pw.BorderRadius.circular(4),
                        ),
                        child: pw.Center(child: pw.Text('LOGO', style: pw.TextStyle(fontSize: 10))),
                      ),
                      pw.SizedBox(height: 12),
                      pw.Text(data.companyName, style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
                      pw.Text(data.companyAddress, style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
                    ],
                  ),
                ),

                pw.SizedBox(height: 8),
                pdfDashedDivider(),
                pw.SizedBox(height: 8),

                _row('No', data.quickSalesId),
                _row('Tanggal', DateUtilsHelper.formatYMDHM(DateTime.parse(data.quickSalesDate))),
                _row('Pelanggan', data.customerNmAcc6),
                _row('Tipe', data.customerGroupName ?? '-'),
                _row('Catatan', data.notes),

                pw.SizedBox(height: 14),
                pdfDashedDivider(),
                pw.SizedBox(height: 14),

                for (var item in data.details)
                  _itemRow(
                    "${item.qty2} ${item.inventory.inventoryName}",
                    CurrencyFormat.toRupiah(item.subTotal),
                    CurrencyFormat.toRupiah((int.parse(item.discValue) * int.parse(item.qty2))),
                    CurrencyFormat.toRupiah(int.parse(item.price2) * (int.parse(item.qty) / int.parse(item.qty2))),
                  ),

                pw.SizedBox(height: 14),
                pdfDashedDivider(),
                pw.SizedBox(height: 14),
                pw.Text("$totalQty2 Item", style: const pw.TextStyle(fontSize: 8)),

                pw.SizedBox(height: 6),
                _calculationRow(l.order_subtotal, CurrencyFormat.toRupiah(salesProvider.subTotalQuickSales()), false),
                _calculationRow(l.order_discount, CurrencyFormat.toRupiah(salesProvider.totalDiscountQuickSales()), false),
                _calculationRow(l.order_grandTotalPayment, CurrencyFormat.toRupiah(salesProvider.grandTotalQuickSales()), true),
                pw.SizedBox(height: 12),
                pw.SizedBox(height: 14),
                pdfDashedDivider(),
                pw.SizedBox(height: 14),
                pw.Center(child: pw.Text('Terima Kasih', style: pw.TextStyle(fontSize: 9))),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _row(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        children: [
          pw.SizedBox(width: 70, child: pw.Text(label, style: const pw.TextStyle(fontSize: 8))),
          pw.Text(': ', style: const pw.TextStyle(fontSize: 8)),
          pw.Expanded(child: pw.Text(value, style: const pw.TextStyle(fontSize: 8))),
        ],
      ),
    );
  }

  pw.Widget _itemRow(String name, String price, String discount, String price2) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 8),
      child: pw.Column(
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text(name, style: const pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.left),
              ),
              pw.Expanded(
                child: pw.Text(price2, style: const pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
              ),
              pw.Expanded(
                child: pw.Text(price, style: const pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.right),
              ),
            ],
          ),
          if (discount != 'Rp 0') ...[
            pw.SizedBox(height: 2),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text('- Diskon', style: const pw.TextStyle(fontSize: 9)),
                pw.SizedBox(width: 10),
                pw.Text(discount, style: const pw.TextStyle(fontSize: 9)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  pw.Widget pdfDashedDivider({double dashWidth = 4, double dashHeight = 0.4, double gap = 2}) {
    return pw.LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints?.maxWidth ?? 0;
        final dashCount = (width / (dashWidth + gap)).floor();

        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return pw.Container(width: dashWidth, height: dashHeight, color: PdfColors.black);
          }),
        );
      },
    );
  }

  pw.Widget _calculationRow(String label, String value, bool isGrandTotal) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Expanded(
            flex: 4,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(label, style: isGrandTotal ? pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold) : pw.TextStyle(fontSize: 8)),
                pw.SizedBox(width: 4),
                pw.Text(': ', style: const pw.TextStyle(fontSize: 8)),
              ],
            ),
          ),
          pw.Expanded(
            flex: 5,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [pw.Text(value, style: const pw.TextStyle(fontSize: 8))],
            ),
          ),
        ],
      ),
    );
  }
}
