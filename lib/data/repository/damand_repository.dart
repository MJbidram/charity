import 'package:charity/data/datasource/demand_datasource.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/damand_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:dartz/dartz.dart';

import '../../constants/constants.dart';

abstract class IDamandRepository {
  //پیگیری وضعیت درخواست
  Future<Either<String, List<DamandListModle>>> followUpDamand();
  //دریافت نوع اول
  Future<Either<String, List<DamandFirstTypeModel>>> getDamandTypes();
  //درییافت نوع دوم
  Future<Either<String, List<DamandSecandTypeModel>>> getDamandSecandTypes(
      String firstType);
  Future<Either<String, String>> sendDamand(String description, String type);
}

class DamandRepository extends IDamandRepository {
  String? token = AuthManager.authChangeNotifire.value;

  final IDamandDateasource _datasource = locator.get();
  @override
  Future<Either<String, List<DamandListModle>>> followUpDamand() async {
    try {
      var response = await _datasource.followUpDamand(token!);
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
  Future<Either<String, List<DamandFirstTypeModel>>> getDamandTypes() async {
    try {
      var response = await _datasource.getDamandTypes(token!);
      return right(response);
    } on ApiException catch (e) {
      if (e.code == 304) {
        return left(ErrorsMessages.unAvailable);
      } else {
        return left(e.message ?? 'خطا محتوای متنی ندارد');
      }
    }
  }

  @override
  Future<Either<String, List<DamandSecandTypeModel>>> getDamandSecandTypes(
      String firstType) async {
    try {
      var response = await _datasource.getDamandSecandTypes(token!, firstType);
      return right(response);
    } on ApiException catch (e) {
      if (e.code == 304) {
        return left(ErrorsMessages.unAvailable);
      } else {
        return left(e.message ?? 'خطا محتوای متنی ندارد');
      }
    }
  }

  @override
  Future<Either<String, String>> sendDamand(
      String description, String type) async {
    try {
      var response = await _datasource.sendDamand(token!, description, type);
      return right(response);
    } on ApiException catch (e) {
      if (e.code == 304) {
        return left(ErrorsMessages.unAvailable);
      } else {
        return left(e.message ?? 'خطا محتوای متنی ندارد');
      }
    }
  }
}
