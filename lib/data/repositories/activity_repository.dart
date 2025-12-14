import 'package:sail_in_co/core/api/api_client.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/core/api/api_response.dart';
import 'package:sail_in_co/data/models/history/history_transaction_payload_model.dart';

class ActivityRepository {
  final ApiClient _api = ApiClient();

  // Get - Activity History 
  Future<ApiResponse> getActivityHistory({required HistoryTransactionPayloadModel payload}) async {
    try {
      final response = await _api.get("${ApiConstants.baseUrl}${ApiConstants.historyTransactions}", query: payload.toQuery());
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }
}
