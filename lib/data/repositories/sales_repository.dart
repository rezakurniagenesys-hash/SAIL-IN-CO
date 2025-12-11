import 'package:sail_in_co/core/api/api_client.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/core/api/api_response.dart';
import 'package:sail_in_co/data/models/salesorder/sales_order_payload_model.dart';

class SalesRepository {
  final ApiClient _api = ApiClient();

  // Post - sales order
  Future<ApiResponse> postSalesOrder({required SalesOrderPayloadModel payload}) async {
    try {
      final response = await _api.post("${ApiConstants.baseUrl}${ApiConstants.salesOrders}", data: payload.toJson());
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }
}
