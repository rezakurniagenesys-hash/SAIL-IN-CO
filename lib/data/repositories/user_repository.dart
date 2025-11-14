import 'package:sail_in_co/core/api/api_client.dart';
import 'package:sail_in_co/core/api/api_constants.dart';
import 'package:sail_in_co/data/models/user_model.dart';

class UserRepository {
  final ApiClient _api = ApiClient();

  Future<UserModel> getProfile() async {
    final res = await _api.get(ApiConstants.userProfile);
    return UserModel.fromJson(res.data);
  }
}
