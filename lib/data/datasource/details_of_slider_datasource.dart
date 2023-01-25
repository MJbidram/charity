import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/pooyesh_model.dart';
import 'package:charity/models/projects_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../util/api_exception.dart';

abstract class DetailsOfSlidersDataSourse {
  Future<PooyeshModel> getPooyeshes(int id);
  Future<ProjectModel> getProjects(int id);
}

class DetailsOfSlidersRemote extends DetailsOfSlidersDataSourse {
  final Dio _dio = locator.get();

  @override
  Future<PooyeshModel> getPooyeshes(int id) async {
    try {
      var response = await _dio.get('${ApiAddress.pooyeshAddress}?id=$id');
      print('${response.data['data']}');
      return PooyeshModel.fromJsonMap(response.data['data']);
    } on DioError catch (e) {
      print(e);
      throw ApiException(e.response!.statusCode, e.message);
    } catch (e) {
      print(e);
      throw ApiException(0, 'خطای ناشناخته');
    }
  }

  @override
  Future<ProjectModel> getProjects(int id) async {
    try {
      print(id);
      var response = await _dio.get('${ApiAddress.projectAddress}?id=$id');
      print('${ApiAddress.projectAddress}?id=$id');

      return ProjectModel.fromJsonMap(response.data['data']);
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.message);
    } catch (e) {
      print(e);
      throw ApiException(0, 'خطای ناشناخته');
    }
  }
}
