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
      headers: {'Accept': 'application/json'},
    ),
  )..interceptors.add(ApiInterceptor());

  Future<ApiResponse> get(String endpoint, {Map<String, dynamic>? query}) async {
    try {
      final res = await _dio.get(endpoint, queryParameters: query);
      return ApiResponse.fromResponse(res);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<ApiResponse> post(String endpoint, {dynamic data}) async {
    try {
      final res = await _dio.post(endpoint, data: data);
      return ApiResponse.fromResponse(res);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<ApiResponse> put(String endpoint, {dynamic data}) async {
    try {
      final res = await _dio.put(endpoint, data: data);
      return ApiResponse.fromResponse(res);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<ApiResponse> delete(String endpoint) async {
    try {
      final res = await _dio.delete(endpoint);
      return ApiResponse.fromResponse(res);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<ApiResponse> uploadImage(String endpoint, File file, {Map<String, dynamic>? fields}) async {
    try {
      final formData = FormData.fromMap({if (fields != null) ...fields, 'file': await MultipartFile.fromFile(file.path, filename: file.uri.pathSegments.last)});
      final res = await _dio.post(endpoint, data: formData);
      return ApiResponse.fromResponse(res);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
