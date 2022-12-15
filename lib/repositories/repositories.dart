import 'package:dio/dio.dart';

import '../models/home_screen_model.dart';

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
}
