import 'package:charity/data/datasource/creat_order_datasource.dart';
import 'package:charity/models/creat_order_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dartz/dartz.dart';

import '../../di/di.dart';

abstract class ICreatOrderRepositorey {
  Future<Either<String, OrderModel>> postOrder(
      String name, int marasem, int type, int tarh);
}

class CreateOrderRepository extends ICreatOrderRepositorey {
  final ICreatOrderDatasource _datasource = locator.get();

  @override
  Future<Either<String, OrderModel>> postOrder(
      String name, int marasem, int type, int tarh) async {
    try {
      var response = await _datasource.postOrder(name, marasem, type, tarh);
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    } catch (e) {
      return left('خطای ناشناخته');
    }
  }
}
