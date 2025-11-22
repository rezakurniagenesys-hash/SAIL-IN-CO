import 'package:dio/dio.dart';
import 'package:sail_in_co/services/auth_service.dart';
import 'package:sail_in_co/data/repositories/auth_repository.dart';
import '../utils/app_logger.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Logging Request
    AppLogger.i("➡️ [REQUEST] ${options.method} ${options.uri}");
    if (options.data != null) AppLogger.i("Body: ${options.data}");

    // Inject Token
    final token = await AuthService.getToken();
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Logging Response
    AppLogger.i("✅ [RESPONSE] ${response.statusCode}: ${response.data}");
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    AppLogger.e("❌ [ERROR] ${err.message}");

    // Jika token expired (401)
    if (err.response?.statusCode == 401) {
      final oldToken = await AuthService.getToken();
      final refreshToken = await AuthService.getRefreshToken();

      if (oldToken != null && refreshToken != null) {
        try {
          final repo = AuthRepository();

          // Refresh token API call
          final newAuth = await repo.refreshToken(oldToken, refreshToken);

          // Save token baru
          await AuthService.saveToken(newAuth.data?.token ?? '', newAuth.data?.refreshToken ?? '');

          // Retry request dengan token baru
          err.requestOptions.headers["Authorization"] = "Bearer ${newAuth.data?.token}";

          final dio = Dio()..interceptors.add(this);
          final retryResponse = await dio.fetch(err.requestOptions);

          return handler.resolve(retryResponse);
        } catch (e) {
          AppLogger.e("❌ Refresh token gagal: $e");

          // Clear session → user harus login ulang
          await AuthService.clear();
        }
      }
    }

    return handler.next(err);
  }
}
