import 'package:charity/constants/constants.dart';
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

      var response = await _dio.get(ApiAddress.factors);
      return response.data['data']
          .map<FactorsModle>(
              (jsonObject) => FactorsModle.fromJsonMap(jsonObject))
          .toList();
    } on DioError catch (e) {
      print(e);
      throw ApiException(e.response!.statusCode, e.message);
    } catch (e) {
      print(e);
      throw ApiException(0, 'خطای ناشناخته');
    }
  }
}
