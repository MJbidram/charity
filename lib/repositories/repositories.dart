import 'package:charity/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';

import '../models/models.dart';

class Repositories {
  Future<HadisModel> getHadisData() async {
    var response = await Dio().get(ApiAddress.hadisAddress);
    var jsonObject = response.data;
    var hadis = HadisModel.fromeJsonMap(jsonObject);
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
    var response = await Dio().get(ApiAddress.homeAddress);

    List<HomePooyeshModel> homePooyeshList = response.data['data']['pooyeshes']
        .map((jsonObject) => HomePooyeshModel.fromJsonMap(jsonObject))
        .toList()
        .cast<HomePooyeshModel>();

    List<HomeProjectsModel> homeProjectsList = response.data['data']['projects']
        .map((jsonObject) => HomeProjectsModel.fromJsonMap(jsonObject))
        .toList()
        .cast<HomeProjectsModel>();

    var jsonObject = response.data['data']['hadis'];

    var hadis = HadisModel.fromeJsonMap(jsonObject);

    return [homePooyeshList, homeProjectsList, hadis];
  }

  Future<List<NewsModel>> gethomePageNews() async {
    var response = await Dio().get(ApiAddress.newsAddressHome);
    List<NewsModel> homeNews = response.data
        .map((jsonObject) => NewsModel.fromJsonObject(jsonObject))
        .toList()
        .cast<NewsModel>();
    return homeNews;
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
    api.gethomePageNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
