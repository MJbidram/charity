import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';

import '../models/models.dart';

class Repositories {
  Future<HadisModel> getHadisData() async {
    var response = await Dio()
        .get('https://khapp.amiralmomenin-kheirieh.ir/api/v1/1/hadis');
    var jsonObject = response.data;
    var hadis = HadisModel.fromeJsonMap(jsonObject);
    return hadis;
  }

  Future<List<PooyeshesModel>> getPooyeshesData() async {
    var response = await Dio()
        .get('https://khapp.amiralmomenin-kheirieh.ir/api/v1/1/pooyesh');

    List<PooyeshesModel> pooyeshesList = response.data['data']
        .map((jsonObject) => PooyeshesModel.fromeJsonMap(jsonObject))
        .toList()
        .cast<PooyeshesModel>();

    print(pooyeshesList[0].pooyeshTitle);
    return pooyeshesList;
  }

  Future<List<ProjectModel>> getprojectData() async {
    var response = await Dio()
        .get('https://khapp.amiralmomenin-kheirieh.ir/api/v1/1/project');

    List<ProjectModel> projectList = response.data['data']
        .map((jsonObject) => ProjectModel.fromeJsonMap(jsonObject))
        .toList()
        .cast<ProjectModel>();

    print(projectList[0].projectTitle);
    return projectList;
  }

  // Future<List<Home>>
  Future<List> getHomeData() async {
    var response =
        await Dio().get('https://khapp.amiralmomenin-kheirieh.ir/api/v1/1');

    var datam = response.data;

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

    print('1');

    print(homeProjectsList[0].titleProjectHome);
    return [homePooyeshList, homeProjectsList, hadis];
    // return projectList;
  }
}

class MyTestApi extends StatefulWidget {
  const MyTestApi({super.key});

  @override
  State<MyTestApi> createState() => _MyTestApiState();
}

class _MyTestApiState extends State<MyTestApi> {
  var getdata = Repositories();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata.getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
