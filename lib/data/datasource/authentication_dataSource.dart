import 'dart:ffi';

import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/information_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

abstract class IAuthenticationDataSurce {
  Future<String> register(
    String username,
    String phone,
    // String email,
    String deviceName,
    String password,
    String paswordConfirm,
  );

  Future<String> login(String phone, String password, String device);
}

class AuthenticationRemote implements IAuthenticationDataSurce {
  var box = Hive.box('information');
  static var checkRegisterErrors;
  static var checkLoginErrors;
  final Dio _dio = locator.get();

  @override
  Future<String> register(
    String username,
    String phone,
    String deviceName,
    String password,
    String paswordConfirm,
  ) async {
    try {
      final response = await _dio.post(ApiAddress.register, data: {
        'name': username,
        'phone': phone,
        // 'email': email,
        'password': password,
        'password_confirmation': paswordConfirm,
        'device_name': deviceName,
      });

      checkRegisterErrors = response.data;
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        var token = response.data['data']['token'];

        box.put('name', username);
        // box.put('email', email);
        box.put('phone', phone);
        return token;
      } else
        return '';
    } on DioError catch (ex) {
      if (ex.response?.data.runtimeType == int) {
        print('${ex.response?.data}');
        throw ApiException(ex.response?.statusCode, 'error int');
      } else {
        throw ApiException(
            ex.response?.statusCode, ex.response?.data['errors']);
      }
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
        var name = response.data['data']['name'];
        var email = response.data['data']['email'];
        box.put('name', name);
        box.put('email', email ?? 'null');
        box.put('phone', phone);
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
