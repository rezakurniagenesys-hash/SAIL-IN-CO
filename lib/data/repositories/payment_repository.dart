import 'package:sail_in_co/core/api/api_client.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/core/api/api_response.dart';
import 'package:sail_in_co/data/models/quicksales/outstanding_payment_payload_model.dart';
import 'package:sail_in_co/data/models/quicksales/quick_sales_payload_model.dart';

class PaymentRepository {
  final ApiClient _api = ApiClient();

  // Get Sales Returns
  Future<ApiResponse> getSalesReturns({required String customerId}) async {
    try {
      final response = await _api.get("${ApiConstants.baseUrl}${ApiConstants.salesReturns.replaceFirst("{customerId}", customerId)}");
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }

  // Get Payment Methods
  Future<ApiResponse> getPaymentMethods({required String noAcc6}) async {
    try {
      final response = await _api.get("${ApiConstants.baseUrl}${ApiConstants.paymentMethods.replaceFirst("{noAcc6}", noAcc6)}");
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }

  // Post - quick sales
  Future<ApiResponse> postQuickSales({required QuickSalesPayloadModel payload}) async {
    try {
      final response = await _api.post("${ApiConstants.baseUrl}${ApiConstants.quickSales}", data: payload.toJson());
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }

  // Post - /invoices/payment-journal
  Future<ApiResponse> postInvoicePaymentJournal({required OutstandingPaymentPayloadModel payload}) async {
    try {
      final response = await _api.post("${ApiConstants.baseUrl}${ApiConstants.invoicePaymentJournal}", data: payload.toJson());
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }
}
