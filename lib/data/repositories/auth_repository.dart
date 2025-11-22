import 'package:dio/dio.dart';
import 'package:sail_in_co/core/api/api_client.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/data/models/auth/auth_response_model.dart';

class AuthRepository {
  final ApiClient _api = ApiClient();

  // Auth
  Future<AuthResponseModel> login(String username, String password) async {
    try {
      final res = await _api.post(ApiConstants.baseUrl + ApiConstants.loginUrl, data: {"username": username, "password": password});
      return AuthResponseModel.fromJson(res.data);
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;

        if (data is Map<String, dynamic>) {
          throw Exception(data["message"] ?? "Unknown error");
        } else if (data is String) {
          throw Exception(data);
        } else {
          throw Exception("Unexpected response type");
        }
      }

      throw Exception("Network error, please try again.");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<bool> verifyToken(String token) async {
    final res = await _api.post(ApiConstants.verifyTokenUrl, data: {"token": token});
    try {
      return res.data["result"] ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<AuthResponseModel> refreshToken(String token, String refreshToken) async {
    final res = await _api.post(ApiConstants.refreshTokenUrl, data: {"token": token, "refresh_token": refreshToken});
    try {
      return AuthResponseModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
