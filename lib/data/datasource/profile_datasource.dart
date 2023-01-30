import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/profile_model.dart';
import 'package:dio/dio.dart';

import '../../util/api_exception.dart';

abstract class ProfileDataSource {
  Future<ProfileModel> getProfile(String token);
  Future<ProfileUpdateModel> updateProfile({
    required String token,
    required String username,
    required String phone,
    required String email,
    required String deviceName,
    required String address,
    // required String password,
    // required String paswordConfirm,
  });
}

class ProfileRemote extends ProfileDataSource {
  final Dio _dio = locator.get();
  @override
  Future<ProfileModel> getProfile(String token) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.get(ApiAddress.profile);

      return ProfileModel.fromJsonMap(response.data['data']);
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (e) {
      print(e);
      throw ApiException(0, 'خطای ناشناخته');
    }
  }

  @override
  Future<ProfileUpdateModel> updateProfile({
    required String token,
    required String username,
    required String phone,
    required String email,
    required String deviceName,
    required String address,
    // required String password,
    // required String paswordConfirm,
  }) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";
      print('.......');
      print(username);
      print(phone);
      print(email);
      print(address);
      final response = await _dio.post(ApiAddress.profileUpdate, data: {
        'name': username,
        'phone': phone,
        'email': email,
        'address': address,
        // 'password': password,
        // 'password_confirmation': paswordConfirm,
        // 'device_name': deviceName,
      });
      print('${response.data['status']}');
      print('${response.data['status']}');
      print('${response.data['status']}');
      print('${response.data['status']}');
      return ProfileUpdateModel.fromJsonMap(response.data);
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (e) {
      print(e);
      throw ApiException(0, 'خطای ناشناخته');
    }
  }
}
