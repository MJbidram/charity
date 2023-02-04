import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/damand_model.dart';
import 'package:charity/util/api_exception.dart';

import 'package:dio/dio.dart';

//دیتاسورس مربوط به درخواست ها
abstract class IDamandDateasource {
  //پیگیری وضعیت درخواست
  Future<List<DamandListModle>> followUpDamand(String token);
  //دریافت نوع نوع درخواست ها
  Future<List<DamandFirstTypeModel>> getDamandTypes(String token);
  //دریافت نوع جزئی تر درخواست ها
  Future<List<DamandSecandTypeModel>> getDamandSecandTypes(
      String token, String firsType);
  //ارسال درخواست
  Future<String> sendDamand(String token, String description, String type);
  Future<String> deleteDaman(String token, String id);
}

class DamandRemote extends IDamandDateasource {
  final Dio _dio = locator.get();

  @override
  Future<List<DamandListModle>> followUpDamand(String token) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.get(ApiAddress.damandList);

      return response.data['data']
          .map<DamandListModle>(
              (jsonObject) => DamandListModle.fromJsonMap(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (e) {
      print(e);
      throw ApiException(0, 'خطای ناشناخته');
    }
  }

  @override
  Future<List<DamandFirstTypeModel>> getDamandTypes(String token) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.get(ApiAddress.damandType);

      return response.data['data']
          .map<DamandFirstTypeModel>(
              (jsonObject) => DamandFirstTypeModel.fromJsonMap(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (e) {
      print(e);
      throw ApiException(0, 'خطای ناشناخته');
    }
  }

  @override
  Future<List<DamandSecandTypeModel>> getDamandSecandTypes(
      String token, String firsType) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.get(ApiAddress.damandSecandType + firsType);

      return response.data['data']
          .map<DamandSecandTypeModel>(
              (jsonObject) => DamandSecandTypeModel.fromJsonMap(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (e) {
      print(e);
      throw ApiException(0, 'خطای ناشناخته');
    }
  }

  @override
  Future<String> sendDamand(
      String token, String description, String type) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.post(ApiAddress.creatDamand, data: {
        'description': description,
        'type': type,
      });
      return 'عملیات موفق';
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (e) {
      print(e);
      throw ApiException(0, 'خطای ناشناخته');
    }
  }

  @override
  Future<String> deleteDaman(String token, String id) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.delete(ApiAddress.deletedamand + id);

      return 'عملیات موفق';
    } on DioError catch (e) {
      print(e.message);
      throw ApiException(e.response?.statusCode, e.message);
    } catch (e) {
      print(e);
      throw ApiException(0, 'خطای ناشناخته');
    }
  }
}
