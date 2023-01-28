import 'package:charity/data/datasource/demand_datasource.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/damand_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dartz/dartz.dart';

import '../../constants/constants.dart';

abstract class IDamandRepository {
  Future<Either<String, List<DamandModle>>> followUpDamand(String token);
  Future<Either<String, List<DamandTypeModel>>> getDamandTypes(String token);
  Future<Either<String, String>> sendDamand(String token);
}

class DamandRepository extends IDamandRepository {
  final IDamandDateasource _datasource = locator.get();
  @override
  Future<Either<String, List<DamandModle>>> followUpDamand(String token) async {
    try {
      var response = await _datasource.followUpDamand(token);
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

  @override
  Future<Either<String, List<DamandTypeModel>>> getDamandTypes(String token) {
    // TODO: implement getDamandTypes
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> sendDamand(String token) {
    // TODO: implement sendDamand
    throw UnimplementedError();
  }
}
