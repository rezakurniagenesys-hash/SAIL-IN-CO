import 'package:dio/dio.dart';
import '../utils/app_logger.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.i("➡️ [REQUEST] ${options.method} ${options.uri}");
    if (options.data != null) AppLogger.i("Body: ${options.data}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.i("✅ [RESPONSE] ${response.statusCode}: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e("❌ [ERROR] ${err.message}");
    super.onError(err, handler);
  }
}
