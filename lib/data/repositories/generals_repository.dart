import 'package:sail_in_co/core/api/api_client.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/core/api/api_response.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_request.dart';

class GeneralsRepository {
  final ApiClient _api = ApiClient();

  // Get General Inventory
  Future<ApiResponse> getGeneralInventory({required GeneralInventoryRequest generalInventoryRequest}) async {
    try {
      final response = await _api.get("${ApiConstants.baseUrl}${ApiConstants.generalInventory}", query: generalInventoryRequest.toQuery());
      return response;
    } catch (e) {
      return ApiResponse(data: null, statusCode: 500, message: e.toString());
    }
  }

  // Get General UOMs
  // Future<ApiResponse> getGeneralUOMs({required int inventoryId}) async {
  //   try {
  //     final url = ApiConstants.generalUOMs.replaceFirst("{id}", inventoryId.toString());
  //     final response = await _api.get("${ApiConstants.baseUrl}$url");
  //     return response;
  //   } catch (e) {
  //     return ApiResponse(data: null, statusCode: 500, message: e.toString());
  //   }
  // }
}
