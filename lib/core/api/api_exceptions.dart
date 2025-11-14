import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  factory ApiException.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException("Connection Timeout");
      case DioExceptionType.receiveTimeout:
        return ApiException("Receive Timeout");
      case DioExceptionType.badResponse:
        return ApiException(e.response?.data["message"] ?? "Server Error");
      default:
        return ApiException("Unexpected Error: ${e.message}");
    }
  }

  @override
  String toString() => message;
}
