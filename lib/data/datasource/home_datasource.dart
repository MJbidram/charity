import 'package:charity/di/di.dart';
import 'package:charity/util/api_exception.dart';
import 'package:dio/dio.dart';

import '../../constants/constants.dart';
import '../../models/home_models.dart';

abstract class HomeDataSource {
  Future<List> getHomeData();
}

class HomeDataRemote implements HomeDataSource {
  final Dio _dio = locator.get();

  late List<HomePooyeshModel> homePooyeshList;
  late List<HomeProjectsModel> homeProjectsList;
  late List<HomeItemsModel> homeItemsList;
  late HadisModel hadis;
  @override
  Future<List> getHomeData() async {
    try {
      var homeDataResponse = await _dio.get(ApiAddress.homeAddress);
      if (homeDataResponse.statusCode == 200) {
        homePooyeshList = homeDataResponse.data['data']['pooyeshes']
            .map((jsonObject) => HomePooyeshModel.fromJsonMap(jsonObject))
            .toList()
            .cast<HomePooyeshModel>();

        homeProjectsList = homeDataResponse.data['data']['projects']
            .map((jsonObject) => HomeProjectsModel.fromJsonMap(jsonObject))
            .toList()
            .cast<HomeProjectsModel>();
        homeItemsList = homeDataResponse.data['data']['homeItems']
            .map((jsonObject) => HomeItemsModel.fromJsonMap(jsonObject))
            .toList()
            .cast<HomeItemsModel>();
        var jsonObject = homeDataResponse.data['data']['hadis'];

        hadis = HadisModel.fromeJsonMap(jsonObject);
      } else {
        throw ApiException(
            homeDataResponse.statusCode, homeDataResponse.statusMessage);
      }
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.message);
    }
    return [homePooyeshList, homeProjectsList, hadis, homeItemsList];
  }
}
