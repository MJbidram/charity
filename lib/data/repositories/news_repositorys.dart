import 'package:dio/dio.dart';

import '../../constants/constants.dart';
import '../../models/news_model.dart';

class NewsRepositorys {
  Future<List<NewsModel>> getNews() async {
    late List<NewsModel> newsPage;

    try {
      var response = await Dio().get(ApiAddress.newsAddress);

      if (response.statusCode == 200) {
        newsPage = response.data
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
    // print(newsPage.length);

    return newsPage;
  }
}
