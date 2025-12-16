import 'package:sail_in_co/core/api/api_client.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/core/api/api_response.dart';
import 'package:sail_in_co/data/models/summary/summary_request.dart';

class HomeRepository {
  final ApiClient _api = ApiClient();

  Future<ApiResponse> getSummaryChart(SummaryRequest request) async {
    try {
      final res = await _api.get(ApiConstants.baseUrl + ApiConstants.summaryChart, query: request.toQuery());

      // return CallsheetSummaryResponse.fromJson(res.data);
      return res;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }

  // Patty Cash
  Future<ApiResponse> getPattyCash({required String userId}) async {
    try {
      final response = await _api.post("${ApiConstants.baseUrl}${ApiConstants.pattyCash}", data: {'user_id': userId});
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }

  // Get - Settlement
  Future<ApiResponse> getSettlement({required String userId}) async {
    try {
      final response = await _api.get("${ApiConstants.baseUrl}${ApiConstants.settlement.replaceFirst('{userId}', userId)}");
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }
}
