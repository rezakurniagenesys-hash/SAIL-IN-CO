import 'package:dio/dio.dart';

class ApiResponse {
  final int? statusCode;
  final String? message;
  final dynamic data;

  ApiResponse({this.statusCode, this.message, this.data});

  factory ApiResponse.fromResponse(Response response) {
    return ApiResponse(statusCode: response.statusCode, message: response.statusMessage, data: response.data);
  }
}
