import 'package:sail_in_co/core/api/api_client.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/data/models/customer/customer_response_model.dart';
import 'package:sail_in_co/data/models/customer/customer_search_request.dart';

class CustomerRepository {
  final ApiClient _api = ApiClient();

  Future<CustomerResponseModel?> getCustomerManagement(CustomerSearchRequest request) async {
    try {
      final response = await _api.get(ApiConstants.baseUrl + ApiConstants.customerSearch, query: request.toQuery());

      return CustomerResponseModel.fromJson(response.data);
    } catch (e) {
      print("Error fetching customer: $e");
      return null;
    }
  }

  // Customer Detail
  Future<CustomerDetailResponse?> getCustomerDetail(String customerId, String scheduleId) async {
    try {
      final response = await _api.get("${ApiConstants.baseUrl}${ApiConstants.customerDetail.replaceFirst("{id}", customerId)}?schedule_id=$scheduleId");

      return CustomerDetailResponse.fromJson(response.data);
    } catch (e) {
      print("Error fetching customer detail: $e");
      return null;
    }
  }
}
