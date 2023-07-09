import 'package:charity/data/datasource/marasemat_datasource.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/marasemat.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IMarasematRepository {
  Future<Either<String, List<MarasematModel>>> getMarasemat();
}

class MarasematRepository extends IMarasematRepository {
  final IMarasematDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<MarasematModel>>> getMarasemat() async {
    try {
      var response = await _dataSource.getMarasemat();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    } catch (e) {
      return left('خطای ناشناخته');
    }
  }
}
