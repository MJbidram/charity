import 'package:charity/data/datasource/wearth_type_datasource.dart';
import 'package:charity/models/wreath_types_model.dart';
import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../models/marasemat.dart';
import '../../util/api_exception.dart';

abstract class IWearthTypeRepository {
  Future<Either<String, WearthTypeModel>> getWearthTypes();
}

class WearthTypeRepository extends IWearthTypeRepository {
  final IWearthTypeDataSource _dataSource = locator.get();
  @override
  Future<Either<String, WearthTypeModel>> getWearthTypes() async {
    try {
      var response = await _dataSource.getWearthType();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    } catch (e) {
      return left('خطای ناشناخته');
    }
  }
}
