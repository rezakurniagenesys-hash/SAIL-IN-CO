import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/ui/widgets/app_bar_custom.dart';

class AppPdfViewerPage extends StatefulWidget {
  final String pdfUrl;
  final String title;

  const AppPdfViewerPage({super.key, required this.pdfUrl, this.title = 'PDF Viewer'});

  @override
  State<AppPdfViewerPage> createState() => _AppPdfViewerPageState();
}

class _AppPdfViewerPageState extends State<AppPdfViewerPage> {
  final Dio _dio = Dio();

  String? localPath;
  bool loading = true;
  double progress = 0;

  int currentPage = 0;
  int totalPages = 0;
  PDFViewController? pdfController;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/temp.pdf';
      final pdfLink = '${ApiConstants.baseUrl}/sales${widget.pdfUrl}';

      await _dio.download(
        pdfLink,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            setState(() {
              progress = received / total;
            });
          }
        },
        options: Options(responseType: ResponseType.bytes, followRedirects: true),
      );

      setState(() {
        localPath = filePath;
        loading = false;
      });
    } catch (e) {
      debugPrint('PDF Load Error: $e');
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: widget.title),
      body: loading
          ? _buildLoading()
          : localPath == null
          ? const Center(child: Text('Gagal memuat PDF'))
          : Column(
              children: [
                Expanded(child: _buildPdfView()),
                _buildBottomBar(),
              ],
            ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [const CircularProgressIndicator(), const SizedBox(height: 12), Text('${(progress * 100).toStringAsFixed(0)} %')],
      ),
    );
  }

  Widget _buildPdfView() {
    return Stack(
      children: [
        PDFView(
          filePath: localPath!,
          enableSwipe: true,
          swipeHorizontal: false, // scroll vertical
          autoSpacing: true,
          pageSnap: true,
          onRender: (pages) {
            setState(() {
              totalPages = pages ?? 0;
            });
          },
          onViewCreated: (controller) {
            pdfController = controller;
          },
          onPageChanged: (page, _) {
            setState(() {
              currentPage = page ?? 0;
            });
          },
        ),

        /// Page Indicator (floating)
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(20)),
            child: Text('Page ${currentPage + 1} / $totalPages', style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8)],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: currentPage > 0
                ? () {
                    pdfController?.setPage(currentPage - 1);
                  }
                : null,
          ),
          Expanded(
            child: Center(
              child: Text('Page ${currentPage + 1} of $totalPages', style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: currentPage + 1 < totalPages
                ? () {
                    pdfController?.setPage(currentPage + 1);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
