import 'package:charity/data/datasource/charity_datasource.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/charity_model.dart';
import 'package:charity/di/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class MyCharityRepository {
  Future<Either<String, List<CharityModel>?>> getFirstTyp();
  Future<Either<String, List<CharityModelSecand>?>> getSecandTyp(
      String firstType);
}

class CharityRepository implements MyCharityRepository {
  final CharityDatasource _charityDatasource = locator.get();
  List<CharityModel>? _charityModel;
  List<CharityModelSecand>? _charityModelSecand;
  @override
  Future<Either<String, List<CharityModel>?>> getFirstTyp() async {
    try {
      _charityModel = await _charityDatasource.getTyps();

      return right(_charityModel);
    } on ApiException catch (e) {
      var er = e.message;
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<CharityModelSecand>?>> getSecandTyp(
      String firstType) async {
    try {
      _charityModelSecand = await _charityDatasource.getSecandTyps(firstType);
      return right(_charityModelSecand);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
