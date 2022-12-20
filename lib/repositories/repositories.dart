import 'package:charity/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class Repositories {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  Future<HadisModel> getHadisData() async {
    late HadisModel hadis;
    try {
      var response = await Dio().get(ApiAddress.hadisAddress);

      if (response.statusCode == 200) {
        var jsonObject = response.data;
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
    return hadis;
  }

  Future<List<PooyeshesModel>> getPooyeshesData() async {
    var response = await Dio().get(ApiAddress.pooyeshAddress);

    List<PooyeshesModel> pooyeshesList = response.data['data']
        .map((jsonObject) => PooyeshesModel.fromeJsonMap(jsonObject))
        .toList()
        .cast<PooyeshesModel>();

    print(pooyeshesList[0].pooyeshTitle);
    return pooyeshesList;
  }

  Future<List<ProjectModel>> getprojectData() async {
    var response = await Dio().get(ApiAddress.projectAddress);

    List<ProjectModel> projectList = response.data['data']
        .map((jsonObject) => ProjectModel.fromeJsonMap(jsonObject))
        .toList()
        .cast<ProjectModel>();

    print(projectList[0].projectTitle);
    return projectList;
  }

  // Future<List<Home>>
  Future<List> getHomeData() async {
    late List<HomePooyeshModel> homePooyeshList;
    late List<HomeProjectsModel> homeProjectsList;
    late HadisModel hadis;
    try {
      var response = await Dio().get(ApiAddress.homeAddress);

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
    await dioPostHeader(ApiAddress.homeAddress);

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
    await dioPostHeader(ApiAddress.newsAddressHome);

    return homeNews;
  }

  Future<List<NewsModel>> getNews() async {
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
    await dioPostHeader(ApiAddress.newsAddressHome);

    return homeNews;
  }

  Future<void> dioPostHeader(String address) async {
    var post = await Dio().post(address,
        options: Options(
          headers: requestHeaders,
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));
    print(post);
  }
}

class TestApi extends StatefulWidget {
  const TestApi({super.key});

  @override
  State<TestApi> createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  var api = Repositories();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    api.getHomePageListNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
