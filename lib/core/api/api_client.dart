import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/core/api/api_exceptions.dart';
import 'package:sail_in_co/core/api/api_interceptor.dart';
import 'package:sail_in_co/core/api/api_response.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
    ),
  )..interceptors.add(ApiInterceptor());

  // --------------------------------------------------------------
  // 🔧 Helper untuk decode jika String JSON
  // --------------------------------------------------------------
  dynamic _normalizeResponse(dynamic data) {
    if (data is String) {
      try {
        return jsonDecode(data);
      } catch (_) {
        return data; // bukan JSON, kembalikan apa adanya
      }
    }
    return data;
  }

  // --------------------------------------------------------------
  // GET
  // --------------------------------------------------------------
  Future<ApiResponse> get(String endpoint, {Map<String, dynamic>? query}) async {
    try {
      final res = await _dio.get(endpoint, queryParameters: query);

      return ApiResponse(statusCode: res.statusCode ?? 0, data: _normalizeResponse(res.data));
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // --------------------------------------------------------------
  // POST
  // --------------------------------------------------------------
  Future<ApiResponse> post(String endpoint, {dynamic data}) async {
    try {
      final res = await _dio.post(endpoint, data: data);

      return ApiResponse(statusCode: res.statusCode ?? 0, data: _normalizeResponse(res.data));
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // --------------------------------------------------------------
  // PUT
  // --------------------------------------------------------------
  Future<ApiResponse> put(String endpoint, {dynamic data}) async {
    try {
      final res = await _dio.put(endpoint, data: data);

      return ApiResponse(statusCode: res.statusCode ?? 0, data: _normalizeResponse(res.data));
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // --------------------------------------------------------------
  // DELETE
  // --------------------------------------------------------------
  Future<ApiResponse> delete(String endpoint) async {
    try {
      final res = await _dio.delete(endpoint);

      return ApiResponse(statusCode: res.statusCode ?? 0, data: _normalizeResponse(res.data));
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // --------------------------------------------------------------
  // UPLOAD FILE
  // --------------------------------------------------------------
  Future<ApiResponse> uploadImage(String endpoint, File file, {Map<String, dynamic>? fields}) async {
    try {
      final formData = FormData.fromMap({if (fields != null) ...fields, 'file': await MultipartFile.fromFile(file.path, filename: file.uri.pathSegments.last)});

      final res = await _dio.post(endpoint, data: formData);

      return ApiResponse(statusCode: res.statusCode ?? 0, data: _normalizeResponse(res.data));
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
