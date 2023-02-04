import 'package:charity/data/datasource/aboutus_datasource.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/aboutus_model.dart';
import 'package:dartz/dartz.dart';

import '../../constants/constants.dart';
import '../../util/api_exception.dart';

abstract class IAboutUsRepository {
  Future<Either<String, AboutUsModel>> getAboutUs();
}

class AboutUsRepository extends IAboutUsRepository {
  final AboutUsDataSource _dataSource = locator.get();
  @override
  Future<Either<String, AboutUsModel>> getAboutUs() async {
    try {
      var response = await _dataSource.getAboutUS();
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
