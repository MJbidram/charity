
// معماری جدید برای صفحه خانه در صورت لزوم
/*
import 'package:charity/data/datasource/home_datasource.dart';
import 'package:charity/di/di.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class MYHomeRepository {
  Future<Either<String, List>> getHomeData();
}

class HomeRepository implements MYHomeRepository {
  final HomeDataSource _dataSource = locator.get();
  List? _list;
  @override
  Future<Either<String, List>> getHomeData() async {
    try {
      _list = await _dataSource.getHomeData();
      return right(_list!);
    } on ApiException catch (e) {
      return left(e.message!);
    }
  }
}*/
