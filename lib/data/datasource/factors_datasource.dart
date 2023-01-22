import 'package:charity/di/di.dart';
import 'package:charity/models/factors_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IFactorsdatasourse {
  Future<List<FactorsModle>> getFactors(String token);
}

class FactorsDatasourse extends IFactorsdatasourse {
  final Dio _dio = locator.get();
  @override
  Future<List<FactorsModle>> getFactors(String token) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $token";

      var response = await _dio.get('profile/faktoors');
      return response.data['data']
          .map<FactorsModle>(
              (jsonObject) => FactorsModle.fromJsonMap(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.message);
    } catch (e) {
      throw ApiException(0, 'خطای ناشناخته');
    }
  }
}
