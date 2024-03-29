import 'package:charity/data/datasource/factors_datasource.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/factors_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dartz/dartz.dart';

import '../../constants/constants.dart';

abstract class IFactorsRepositorys {
  Future<Either<String, List<FactorsModle>>> getFactors(String token);
}

class FactorsRepositorys extends IFactorsRepositorys {
  final IFactorsdatasourse _factors = locator.get();
  @override
  Future<Either<String, List<FactorsModle>>> getFactors(String token) async {
    try {
      var response = await _factors.getFactors(token);
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
