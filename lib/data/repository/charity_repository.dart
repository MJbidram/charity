import 'package:charity/constants/constants.dart';
import 'package:charity/data/datasource/charity_datasource.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/charity_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class MyCharityRepository {
  Future<Either<String, List<CharityModelFirst>>> getFirstTyp();
  Future<Either<String, List<CharityModelSecand>>> getSecandTyp(
      String firstType);
}

class CharityRepository implements MyCharityRepository {
  final CharityDatasource _charityDatasource = locator.get();

  @override
  Future<Either<String, List<CharityModelFirst>>> getFirstTyp() async {
    try {
      var _charityModel = await _charityDatasource.getTyps();

      return right(_charityModel);
    } on ApiException catch (e) {
      if (e.code == 304) {
        return left(ErrorsMessages.unAvailable);
      } else {
        return left(e.message ?? 'خطا محتوای متنی ندارد');
      }
    }
  }

  @override
  Future<Either<String, List<CharityModelSecand>>> getSecandTyp(
      String firstType) async {
    try {
      var _charityModelSecand =
          await _charityDatasource.getSecandTyps(firstType);
      return right(_charityModelSecand);
    } on ApiException catch (e) {
      if (e.code == 304) {
        return left(ErrorsMessages.unAvailable);
      } else {
        return left(e.message ?? 'خطا محتوای متنی ندارد');
      }
    }
  }
}
