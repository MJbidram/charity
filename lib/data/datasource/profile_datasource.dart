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
      var details = new Map();
      _dio.options.headers["Authorization"] = "Bearer $token";
      print('.......');
      print('.......');
      print('.......');

      if (username.isNotEmpty) {
        details['name'] = username;
      }
      if (phone.isNotEmpty) {
        details['phone'] = phone;
      }
      if (email.isNotEmpty) {
        details['email'] = email;
      }
      if (address.isNotEmpty) {
        details['address'] = address;
      }
      if (details.isNotEmpty) {
        final response =
            await _dio.post(ApiAddress.profileUpdate, data: details);

        return ProfileUpdateModel.fromJsonMap(response.data);
      } else {
        throw ApiException(0, 'تغییری ایجاد نشده است');
      }
    } on DioError catch (e) {
      print(e);
      throw ApiException(e.response?.statusCode, e.message);
    } catch (e) {
      print(e);
      throw ApiException(0, 'خطای ناشناخته');
    }
  }
}
