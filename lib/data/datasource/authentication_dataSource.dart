import 'dart:ffi';

import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/di/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IAuthenticationDataSurce {
  Future<String> register(
    String username,
    String phone,
    String email,
    String deviceName,
    String password,
    String paswordConfirm,
  );

  Future<String> login(String phone, String password, String device);
}

class AuthenticationRemote implements IAuthenticationDataSurce {
  static var checkRegisterErrors;
  static var checkLoginErrors;
  final Dio _dio = locator.get();

  @override
  Future<String> register(
    String username,
    String phone,
    String email,
    String deviceName,
    String password,
    String paswordConfirm,
  ) async {
    try {
      final response = await _dio.post(ApiAddress.register, data: {
        'name': username,
        'phone': phone,
        'email': email,
        'password': password,
        'password_confirmation': paswordConfirm,
        'device_name': deviceName,
      });

      checkRegisterErrors = response.data;
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return response.data['data']['token'];
      } else
        return '';
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['errors']);
    } catch (ex) {
      throw ApiException(0, 'error');
    }
  }

  @override
  Future<String> login(String phone, String password, String device) async {
    try {
      var response = await _dio.post(ApiAddress.login, data: {
        'phone': phone,
        'password': password,
        'device_name': device,
      });
      checkLoginErrors = response.data;

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return response.data['data']['token'];
      } else
        return '';
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['errors']);
    } catch (ex) {
      throw ApiException(0, 'error');
    }
  }
}
