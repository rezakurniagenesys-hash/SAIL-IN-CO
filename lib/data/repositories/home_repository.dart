import 'package:fluttertoast/fluttertoast.dart';
import 'package:sail_in_co/core/api/api_client.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/data/models/summary/callsheet_summary_response.dart';
import 'package:sail_in_co/data/models/summary/summary_request.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  final ApiClient _api = ApiClient();

  Future<CallsheetSummaryResponse> getSummaryChart(SummaryRequest request) async {
    try {
      final res = await _api.get(ApiConstants.baseUrl + ApiConstants.summaryChart, query: request.toQuery());

      return CallsheetSummaryResponse.fromJson(res.data);
    } on DioException catch (e) {
      // Ambil pesan error dari server atau fallback
      final msg = e.response?.data['message'] ?? "Gagal memuat data summary chart";

      Fluttertoast.showToast(msg: msg); 

      throw Exception(msg); // lempar ke atas
    } catch (e) {
      Fluttertoast.showToast(msg: "Terjadi kesalahan internal");
      throw Exception("Internal error: $e");
    }
  }
}
