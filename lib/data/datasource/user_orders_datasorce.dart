import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/factors_model.dart';
import 'package:charity/models/user_orders_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dio/dio.dart';

import '../../util/auth_manager.dart';

abstract class IUserOrdersDatasource {
  Future<List<UserOrdersModel>> getUserOrders();
}

class UserOrderDatasourse extends IUserOrdersDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<UserOrdersModel>> getUserOrders() async {
    try {
      var token = await AuthManager.readauth();
      _dio.options.headers["Authorization"] = "Bearer $token";

      var response = await _dio.get(ApiAddress.userOrders);
      return response.data['data']
          .map<UserOrdersModel>(
              (jsonObject) => UserOrdersModel.fromJson(jsonObject))
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
