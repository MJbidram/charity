import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/charity_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class CharityDatasource {
  Future<List<CharityModelFirst>> getTyps();
  Future<List<CharityModelSecand>> getSecandTyps(String firstType);
  Future<List<String>> openPaymentPage(String type, String amount);
}

class CharityRemote implements CharityDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<CharityModelFirst>> getTyps() async {
    try {
      final response = await _dio.get(ApiAddress.type);
      if (response.statusCode == 200) {
        print('{${response.data['data']}}');
        return response.data['data']
            .map((jsonObject) => CharityModelFirst.fromJsonMap(jsonObject))
            .toList()
            .cast<CharityModelFirst>();
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
        var responseData = response.data['data']
            .map((jsonObject) => CharityModelSecand.fromJsonMap(jsonObject))
            .toList()
            .cast<CharityModelSecand>();
        print('$responseData');
        return responseData;
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
