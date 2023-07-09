import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/marasemat.dart';
import 'package:charity/util/api_exception.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:dio/dio.dart';

abstract class IMarasematDataSource {
  Future<List<MarasematModel>> getMarasemat();
}

class MarasematRemote extends IMarasematDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<MarasematModel>> getMarasemat() async {
    try {
      var token = await AuthManager.readauth();
      _dio.options.headers["Authorization"] = "Bearer $token";
      var response = await _dio.get(ApiAddress.marasemat);
      return response.data['data']
          .map<MarasematModel>(
              (jsonObject) => MarasematModel.fromJson(jsonObject))
          .toList();
      // return  response.data['data'].map<MarasematModel> (json)=> MarasematModel.fromjson(json).toList();
      // return MarasematModel.fromJson(response.data);
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.message);
    } catch (e) {
      throw ApiException(0, 'خطای ناشناخته');
    }
  }
}
