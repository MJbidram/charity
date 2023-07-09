import 'package:charity/constants/constants.dart';
import 'package:charity/models/creat_order_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../util/auth_manager.dart';

abstract class ICreatOrderDatasource {
  Future<OrderModel> postOrder(String name, int marasem, int type, int tarh);
}

class CreatOrderReomote extends ICreatOrderDatasource {
  final Dio _dio = locator.get();

  @override
  Future<OrderModel> postOrder(
      String name, int marasem, int type, int tarh) async {
    try {
      var token = await AuthManager.readauth();
      _dio.options.headers["Authorization"] = "Bearer $token";
      var response = await _dio.post(ApiAddress.creatOrder, data: {
        "bename": name,
        "marasem": marasem,
        "type": type,
        "tarh": tarh,
      });
      return OrderModel.fromJson(response.data);
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.message);
    } catch (e) {
      throw ApiException(0, 'خطای ناشناخته');
    }
  }
}
