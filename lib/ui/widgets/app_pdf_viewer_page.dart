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

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/temp.pdf';
      final pdflink = '${ApiConstants.baseUrl}/sales${widget.pdfUrl}';

      await _dio.download(
        pdflink,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
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
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const CircularProgressIndicator(), const SizedBox(height: 12), Text('${(progress * 100).toStringAsFixed(0)} %')],
              ),
            )
          : localPath == null
          ? const Center(child: Text('Gagal memuat PDF'))
          : PDFView(filePath: localPath!, enableSwipe: true, swipeHorizontal: false, autoSpacing: true, pageSnap: true),
    );
  }
}
