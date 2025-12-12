import 'package:sail_in_co/core/api/api_client.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/core/api/api_response.dart';
import 'package:sail_in_co/data/models/history/sales_order_request_model.dart';
import 'package:sail_in_co/data/models/history/shipping_sales_order_payload.dart';
import 'package:sail_in_co/data/models/salesorder/sales_order_payload_model.dart';
import 'package:sail_in_co/data/models/salesorder/sales_return_payment_payload.dart';

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

  // Get - List Outstanding Sales Orders
  Future<ApiResponse> getOutstandingSalesOrders({required SalesOrderRequestModel payload}) async {
    try {
      final response = await _api.get("${ApiConstants.baseUrl}${ApiConstants.salesOrders}", query: payload.toQuery());
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }

  // Get - Detail Outstanding Sales Orders
  Future<ApiResponse> getDetailOutstandingSalesOrders({required String salesOrderId}) async {
    try {
      final response = await _api.get("${ApiConstants.baseUrl}${ApiConstants.salesOrders}/$salesOrderId");
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }

  // Post - Shipping for Sales Order
  Future<ApiResponse> postShippingForSalesOrder({required ShippingSalesOrderPayload payload}) async {
    try {
      final response = await _api.post("${ApiConstants.baseUrl}${ApiConstants.shippings}", data: payload);
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }

  // Post - Sales Return
  Future<ApiResponse> potstSalesReturn({required SalesReturnPaymentPayload payload}) async {
    try {
      final response = await _api.post("${ApiConstants.baseUrl}${ApiConstants.returnPayments}", data: payload);
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }
}
