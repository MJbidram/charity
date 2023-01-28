import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/damand_model.dart';
import 'package:charity/util/api_exception.dart';

import 'package:dio/dio.dart';

//دیتاسورس مربوط به درخواست ها
abstract class IDamandDateasource {
  Future<List<DamandModle>> followUpDamand(String token);
  Future<List<DamandTypeModel>> getDamandTypes(String token);
  Future<String> sendDamand(String token);
}

class DamandRemote extends IDamandDateasource {
  final Dio _dio = locator.get();

  @override
  Future<List<DamandModle>> followUpDamand(String token) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.get(ApiAddress.damand);
      return response.data['data']
          .map<DamandModle>((jsonObject) => DamandModle.fromJsonMap(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    } catch (e) {
      print(e);
      throw ApiException(0, 'خطای ناشناخته');
    }
  }

  @override
  Future<List<DamandTypeModel>> getDamandTypes(String token) {
    // TODO: implement getDamandTypes
    throw UnimplementedError();
  }

  @override
  Future<String> sendDamand(String token) {
    // TODO: implement sendDamand
    throw UnimplementedError();
  }
}
