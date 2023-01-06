import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/charity_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class CharityDatasource {
  Future<List<CharityModel>> getTyps();
  Future<List<CharityModelSecand>> getSecandTyps(String firstType);
  Future<List<String>> openPaymentPage(String type, String amount);
}

class CharityRemote implements CharityDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<CharityModel>> getTyps() async {
    try {
      final response = await _dio.get(ApiAddress.type);
      if (response.statusCode == 200) {
        print('{${response.data['data']}}');
        return response.data['data']
            .map((jsonObject) => CharityModel.fromJsonMap(jsonObject))
            .toList()
            .cast<CharityModel>();
      } else
        throw ApiException(response.statusCode, response.statusMessage);
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data);
    } catch (e) {
      throw ApiException(0, e.toString());
    }
  }

  @override
  Future<List<CharityModelSecand>> getSecandTyps(String firstType) async {
    try {
      final response = await _dio.get(ApiAddress.secandType + firstType);
      if (response.statusCode == 200) {
        print('{${response.data['data']}}');
        var eee = response.data['data'][firstType];
        return response.data['data'][firstType]
            .map((jsonObject) => CharityModelSecand.fromJsonMap(jsonObject))
            .toList()
            .cast<CharityModelSecand>();
      } else
        throw ApiException(response.statusCode, response.statusMessage);
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.response?.data);
    } catch (e) {
      throw ApiException(0, e.toString());
    }
  }

  @override
  Future<List<String>> openPaymentPage(String type, String amount) {
    // TODO: implement openPaymentPage
    throw UnimplementedError();
  }
}
