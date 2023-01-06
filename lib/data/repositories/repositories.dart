// import 'package:charity/constants/constants.dart';
// import 'package:charity/di/di.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// import '../models/home_models.dart';
// import '../models/models.dart';

// class Repositories {
//   Map<String, String> requestHeaders = {
//     'Content-type': 'application/json',
//     'Accept': 'application/json',
//   };
//   final Dio _dio = locator.get();
//   Future<HadisModel> getHadisData() async {
//     late HadisModel hadis;
//     try {
//       var response = await _dio.get(ApiAddress.hadisAddress);

//       if (response.statusCode == 200) {
//         var jsonObject = response.data;
//         hadis = HadisModel.fromeJsonMap(jsonObject);
//       } else {
//         print('exception throwed in Try');
//       }
//     } on DioError catch (e) {
//       if (e.response != null) {
//         print('Dio error!');
//         print('STATUS: ${e.response?.statusCode}');
//         print('DATA: ${e.response?.data}');
//         print('HEADERS: ${e.response?.headers}');
//       } else {
//         print('Error sending request!');
//         print(e.message);
//       }
//     }
//     return hadis;
//   }

//   Future<List<PooyeshesModel>> getPooyeshesData() async {
//     var response = await _dio.get(ApiAddress.pooyeshAddress);

//     List<PooyeshesModel> pooyeshesList = response.data['data']
//         .map((jsonObject) => PooyeshesModel.fromeJsonMap(jsonObject))
//         .toList()
//         .cast<PooyeshesModel>();

//     print(pooyeshesList[0].pooyeshTitle);
//     return pooyeshesList;
//   }

//   Future<List<ProjectModel>> getprojectData() async {
//     var response = await _dio.get(ApiAddress.projectAddress);

//     List<ProjectModel> projectList = response.data['data']
//         .map((jsonObject) => ProjectModel.fromeJsonMap(jsonObject))
//         .toList()
//         .cast<ProjectModel>();

//     print(projectList[0].projectTitle);
//     return projectList;
//   }


//   Future<void> dioPostHeader(String address) async {
//     var post = await Dio().post(address,
//         options: Options(
//           headers: requestHeaders,
//           validateStatus: (_) => true,
//           contentType: Headers.jsonContentType,
//           responseType: ResponseType.json,
//         ));
//     print(post);
//   }
// }
