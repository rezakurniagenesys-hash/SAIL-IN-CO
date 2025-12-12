import 'dart:io';

import 'package:sail_in_co/core/api/api_client.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/core/api/api_response.dart';
// import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/data/models/customer/customer_response_model.dart';
import 'package:sail_in_co/data/models/customer/customer_search_request.dart';
import 'package:sail_in_co/data/models/customer/upload_foto/customer_upload_foto_request.dart';
import 'package:sail_in_co/data/models/customer/upload_foto/customer_upload_foto_response.dart';

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

  Future<CustomerResponseModel?> getSearchVisit(CustomerSearchRequest request) async {
    try {
      final response = await _api.get(ApiConstants.baseUrl + ApiConstants.customerSearchVisit, query: request.toQuery());

      return CustomerResponseModel.fromJson(response.data);
    } catch (e) {
      print("Error fetching customer: $e");
      return null;
    }
  }

  // Customer Detail
  Future<ApiResponse> getCustomerDetail(String customerId, String scheduleId) async {
    try {
      final response = await _api.get("${ApiConstants.baseUrl}${ApiConstants.customerDetail.replaceFirst("{id}", customerId)}?schedule_id=$scheduleId");

      // return CustomerDetailResponse.fromJson(response.data);
      return response;
    } catch (e) {
      print("Error fetching customer detailsssssss: $e");
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }

  // Customer Update Photo
  Future<CustomerUploadFotoResponse> updateCustomerPhoto(String customerId, String scheduleId, File file, CustomerUploadFotoRequest request) async {
    try {
      final response = await _api.uploadImage(
        "${ApiConstants.baseUrl}${ApiConstants.customerUpdatePhoto.replaceFirst("{id}", customerId)}?schedule_id=$scheduleId",
        file,
        fields: request.toJson(),
      );

      return CustomerUploadFotoResponse.fromJson(response.data);
    } catch (e) {
      print("Error uploading customer photo: $e");
      rethrow;
    }
  }
}
