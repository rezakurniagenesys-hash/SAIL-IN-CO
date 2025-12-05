import 'package:sail_in_co/core/api/api_client.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/core/api/api_response.dart';
import 'package:sail_in_co/data/models/stock/stock_request.dart';

class StockRepository {
  final ApiClient _api = ApiClient();

  // Get Stock
  Future<ApiResponse> getStock({required StockRequest stockRequest}) async {
    try {
      final response = await _api.get("${ApiConstants.baseUrl}${ApiConstants.stockUrl}/${stockRequest.warehouseId}", query: stockRequest.toQueryParams());
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }
}
