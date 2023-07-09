import 'package:charity/data/datasource/factors_datasource.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/factors_model.dart';
import 'package:charity/models/user_orders_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dartz/dartz.dart';

import '../../constants/constants.dart';
import '../datasource/user_orders_datasorce.dart';

abstract class IUserOrdersRepositorys {
  Future<Either<String, List<UserOrdersModel>>> getUserOrders();
}

class UserOrderRepository extends IUserOrdersRepositorys {
  final IUserOrdersDatasource _userOrders = locator.get();
  @override
  Future<Either<String, List<UserOrdersModel>>> getUserOrders() async {
    try {
      var response = await _userOrders.getUserOrders();
      print(response);
      return right(response);
    } on ApiException catch (e) {
      if (e.code == 304) {
        return left(ErrorsMessages.unAvailable);
      } else {
        return left(e.message ?? 'خطا محتوای متنی ندارد');
      }
    } catch (e) {
      return left('خطای ناشناخته');
    }
  }
}
