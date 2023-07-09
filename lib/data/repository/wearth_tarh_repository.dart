import 'package:charity/data/datasource/wearth_tarh_datasource.dart';
import 'package:charity/data/datasource/wearth_type_datasource.dart';
import 'package:charity/models/wreath_tarh_model.dart';
import 'package:charity/models/wreath_types_model.dart';
import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../models/marasemat.dart';
import '../../util/api_exception.dart';

abstract class IWearthTarhRepository {
  Future<Either<String, WreathTarhModel>> getWearthTarhes();
}

class WearthTarhRepository extends IWearthTarhRepository {
  final IWearthTarhDataSource _dataSource = locator.get();
  @override
  Future<Either<String, WreathTarhModel>> getWearthTarhes() async {
    try {
      var response = await _dataSource.getWearthTarh();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    } catch (e) {
      return left('خطای ناشناخته');
    }
  }
}
