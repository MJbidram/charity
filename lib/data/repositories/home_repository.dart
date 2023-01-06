import 'package:dio/dio.dart';

import '../../constants/constants.dart';
import '../../di/di.dart';
import '../../models/home_models.dart';
import '../../models/news_model.dart';

class HomeRepository {
  final Dio _dio = locator.get();
  Future<List> getHomeData() async {
    late List<HomePooyeshModel> homePooyeshList;
    late List<HomeProjectsModel> homeProjectsList;
    late HadisModel hadis;
    try {
      var response = await _dio.get(ApiAddress.homeAddress);

      if (response.statusCode == 200) {
        homePooyeshList = response.data['data']['pooyeshes']
            .map((jsonObject) => HomePooyeshModel.fromJsonMap(jsonObject))
            .toList()
            .cast<HomePooyeshModel>();

        homeProjectsList = response.data['data']['projects']
            .map((jsonObject) => HomeProjectsModel.fromJsonMap(jsonObject))
            .toList()
            .cast<HomeProjectsModel>();

        var jsonObject = response.data['data']['hadis'];

        hadis = HadisModel.fromeJsonMap(jsonObject);
      } else {
        print('exception throwed in Try');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    // await dioPostHeader(ApiAddress.baseApiUrl);

    return [homePooyeshList, homeProjectsList, hadis];
  }

  Future<List<NewsModel>> getHomePageListNews() async {
    late List<NewsModel> homeNews;

    try {
      var response = await Dio().get(ApiAddress.newsAddressHome);

      if (response.statusCode == 200) {
        homeNews = response.data
            .map((jsonObject) => NewsModel.fromJsonObject(jsonObject))
            .toList()
            .cast<NewsModel>();
      } else {
        print('exception throwed in Try');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    // await dioPostHeader(ApiAddress.newsAddressHome);

    return homeNews;
  }
}
