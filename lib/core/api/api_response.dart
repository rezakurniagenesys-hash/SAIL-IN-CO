import 'package:dio/dio.dart';

class ApiResponse {
  final int? statusCode;
  final dynamic data;

  ApiResponse({this.statusCode, this.data});

  factory ApiResponse.fromResponse(Response response) {
    return ApiResponse(statusCode: response.statusCode, data: response.data);
  }
}
