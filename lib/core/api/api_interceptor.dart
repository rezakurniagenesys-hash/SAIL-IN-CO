import 'package:dio/dio.dart';
import 'package:sail_in_co/services/auth_service.dart';
import 'package:sail_in_co/data/repositories/auth_repository.dart';
import '../utils/app_logger.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;

  ApiInterceptor({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    AppLogger.i("➡️ [REQUEST] ${options.method} ${options.uri}");
    if (options.data != null) AppLogger.i("Body: ${options.data}");

    final token = await AuthService.getToken();
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.i("✅ [RESPONSE] ${response.statusCode}: ${response.data}");
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    AppLogger.e("❌ [ERROR] ${err.message}");

    if (err.response?.statusCode == 401) {
      final oldToken = await AuthService.getToken();
      final refreshToken = await AuthService.getRefreshToken();

      if (oldToken != null && refreshToken != null) {
        try {
          final repo = AuthRepository();

          final newAuth = await repo.refreshToken(oldToken, refreshToken);

          await AuthService.saveToken(newAuth.data?.token ?? '', newAuth.data?.refreshToken ?? '');

          err.requestOptions.headers["Authorization"] = "Bearer ${newAuth.data?.token}";

          // retry dengan DIO yg sama
          final retryResponse = await dio.fetch(err.requestOptions);

          return handler.resolve(retryResponse);
        } catch (e) {
          AppLogger.e("❌ Refresh token gagal: $e");
          await AuthService.clear();
        }
      }
    }

    return handler.next(err);
  }
}
