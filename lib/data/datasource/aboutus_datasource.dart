import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/aboutus_model.dart';
import 'package:dio/dio.dart';

import '../../util/api_exception.dart';

abstract class AboutUsDataSource {
  Future<AboutUsModel> getAboutUS();
}

class AboutUsRemot extends AboutUsDataSource {
  final Dio _dio = locator.get();
  @override
  Future<AboutUsModel> getAboutUS() async {
    try {
      var response = await _dio.get(ApiAddress.aboutUs);
      return AboutUsModel.fromJsonMap(response.data[0]);
    } on DioError catch (e) {
      print(e.message);
      throw ApiException(e.response!.statusCode, e.message);
    } catch (e) {
      print(e.toString());
      throw ApiException(0, 'خطای ناشناخته');
    }
  }
}
