import 'package:charity/data/datasource/details_of_slider_datasource.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/pooyesh_model.dart';
import 'package:charity/models/projects_model.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dartz/dartz.dart';

import '../../constants/constants.dart';

abstract class IDetailsOfSlidersRepositotys {
  Future<Either<String, PooyeshModel>> getPooyeshDetails(int id);
  Future<Either<String, ProjectModel>> getProjectDetails(int id);
}

class DetailsSlidersRepositorys extends IDetailsOfSlidersRepositotys {
  final DetailsOfSlidersDataSourse _detailsDatasourse = locator.get();

  @override
  Future<Either<String, PooyeshModel>> getPooyeshDetails(int id) async {
    try {
      var response = await _detailsDatasourse.getPooyeshes(id);
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
  Future<Either<String, ProjectModel>> getProjectDetails(int id) async {
    try {
      var response = await _detailsDatasourse.getProjects(id);
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
