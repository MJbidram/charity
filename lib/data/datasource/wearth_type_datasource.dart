import 'package:charity/models/wreath_types_model.dart';
import 'package:dio/dio.dart';

import '../../constants/constants.dart';
import '../../di/di.dart';
import '../../util/api_exception.dart';
import '../../util/auth_manager.dart';

abstract class IWearthTypeDataSource {
  Future<WearthTypeModel> getWearthType();
}

class WearthTypeRemote extends IWearthTypeDataSource {
  final Dio _dio = locator.get();

  @override
  Future<WearthTypeModel> getWearthType() async {
    try {
      var token = await AuthManager.readauth();
      _dio.options.headers["Authorization"] = "Bearer $token";
      var response = await _dio.get(ApiAddress.wearthType);
      return WearthTypeModel.fromJson(response.data);
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.message);
    } catch (e) {
      throw ApiException(0, 'خطای ناشناخته');
    }
  }
}
